#!/bin/bash
# AWS Config Nuclear Cleanup with WORKING Backup & Restore (Refactor v4)
# Author/Contact: khalillyons@gmail.com | (703) 795-4193
# Usage:
#   bash nuclear-cleanup-service.sh <CLIENT_CODE> --mode nuclear|backup \
#        [--restore-mode managed|full] [--backup-s3 s3://bucket/prefix] [--yes]
# Examples:
#   bash nuclear-cleanup-service.sh CLIENT_20250822 --mode nuclear --restore-mode managed --yes
#   bash nuclear-cleanup-service.sh CLIENT_20250822 --mode backup --backup-s3 s3://mybucket/prefix --yes

set -euo pipefail

# ------------------------------- Args & Flags -------------------------------
CLIENT_CODE="${1:-}"
shift || true

MODE="interactive"           # nuclear|backup|interactive
RESTORE_MODE="managed"       # managed|full (affects generated restore script defaults)
BACKUP_S3=""                 # s3://bucket/prefix (optional)
ASSUME_YES="false"

while (( "$#" )); do
  case "$1" in
    --mode)           MODE="${2:-}"; shift 2;;
    --restore-mode)   RESTORE_MODE="${2:-managed}"; shift 2;;
    --backup-s3)      BACKUP_S3="${2:-}"; shift 2;;
    --yes|-y)         ASSUME_YES="true"; shift;;
    *) echo "Unknown flag: $1"; exit 1;;
  esac
done

if [ -z "$CLIENT_CODE" ]; then
  echo "❌ CLIENT_CODE is required."; echo "   Usage: bash nuclear-cleanup-service.sh <CLIENT_CODE> [flags]"; exit 1
fi
if ! command -v aws >/dev/null 2>&1; then echo "❌ aws CLI not found"; exit 1; fi
if ! command -v jq  >/dev/null 2>&1; then
  echo "❌ jq required. Attempting install…"
  sudo yum -y install jq 2>/dev/null || sudo apt-get -y install jq 2>/dev/null || { echo "Install jq and retry."; exit 1; }
fi
aws sts get-caller-identity >/dev/null || { echo "❌ AWS creds invalid. Run: aws configure"; exit 1; }

# ------------------------------- Helpers ------------------------------------
regions() { aws ec2 describe-regions --query 'Regions[].RegionName' --output text; }

retry() { # retry <max_attempts> <sleep_base> <cmd...>
  local max="${1:-5}"; local base="${2:-1}"; shift 2
  local attempt=1
  until "$@"; do
    local rc=$?
    if (( attempt >= max )); then return $rc; fi
    sleep $(( base * attempt ))
    attempt=$(( attempt + 1 ))
  done
}

timestamp() { date +%Y%m%d_%H%M%S; }
NOW="$(timestamp)"
BACKUP_DIR="CONFIG_BACKUP_${CLIENT_CODE}_${NOW}"
mkdir -p "$BACKUP_DIR"

log() { echo -e "$@"; }

confirm() {
  local prompt="$1"
  if [ "$ASSUME_YES" = "true" ]; then return 0; fi
  read -p "$prompt " ans
  [[ "$ans" =~ ^(y|Y|yes|YES)$ ]]
}

# --------------------------- Phase 1: Backup --------------------------------
log "🔍 Phase 1: Discovery & WORKING Backup → $BACKUP_DIR"

TOTAL_RULES=0
REGIONS_WITH_RULES=0
REGIONS_LIST=$(regions)

cat > "$BACKUP_DIR/backup_metadata.json" <<EOF
{
  "client_code": "$CLIENT_CODE",
  "backup_date": "$(date -Iseconds)",
  "version": "4.0",
  "restore_capability": "working",
  "regions": [],
  "total_rules": 0,
  "default_restore_mode": "$RESTORE_MODE"
}
EOF

for r in $REGIONS_LIST; do
  log "   • Backing up region: $r"
  retry 5 1 aws configservice describe-config-rules --region "$r" --output json \
    > "$BACKUP_DIR/config_rules_${r}.json" 2>/dev/null || true

  if [ -s "$BACKUP_DIR/config_rules_${r}.json" ]; then
    RCOUNT=$(jq '.ConfigRules | length' "$BACKUP_DIR/config_rules_${r}.json" 2>/dev/null || echo 0)
    if [ "$RCOUNT" -gt 0 ]; then
      TOTAL_RULES=$(( TOTAL_RULES + RCOUNT ))
      REGIONS_WITH_RULES=$(( REGIONS_WITH_RULES + 1 ))
      retry 5 1 aws configservice describe-remediation-configurations   --region "$r" --output json > "$BACKUP_DIR/remediation_configs_${r}.json" 2>/dev/null || true
      retry 5 1 aws configservice describe-conformance-packs            --region "$r" --output json > "$BACKUP_DIR/conformance_packs_${r}.json"  2>/dev/null || true
      retry 5 1 aws configservice describe-delivery-channels            --region "$r" --output json > "$BACKUP_DIR/delivery_channels_${r}.json"  2>/dev/null || true
      retry 5 1 aws configservice describe-configuration-recorders      --region "$r" --output json > "$BACKUP_DIR/config_recorders_${r}.json"   2>/dev/null || true
    else
      rm -f "$BACKUP_DIR/config_rules_${r}.json"
    fi
  fi
done

# finalize metadata
cat > "$BACKUP_DIR/backup_metadata.json" <<EOF
{
  "client_code": "$CLIENT_CODE",
  "backup_date": "$(date -Iseconds)",
  "version": "4.0",
  "restore_capability": "working",
  "regions_with_rules": $REGIONS_WITH_RULES,
  "total_rules": $TOTAL_RULES,
  "backup_dir": "$BACKUP_DIR",
  "default_restore_mode": "$RESTORE_MODE"
}
EOF

log "   ✅ Rules found: $TOTAL_RULES across $REGIONS_WITH_RULES regions"

# Optional: copy to S3
if [ -n "$BACKUP_S3" ]; then
  log "☁️  Copying backup to $BACKUP_S3"
  retry 5 2 aws s3 cp "$BACKUP_DIR/" "$BACKUP_S3/$BACKUP_DIR/" --recursive
  log "   ✅ S3 copy complete"
fi

# --------------------- Phase 2: Generate WORKING Restore --------------------
log "📦 Phase 2: Generating WORKING Restore Script"

RESTORE_SCRIPT="$BACKUP_DIR/${CLIENT_CODE}_RESTORE_SCRIPT.sh"
cat > "$RESTORE_SCRIPT" <<'RESTORE_EOF'
#!/bin/bash
set -euo pipefail

MODE="${1:-managed}"  # managed|full
if ! command -v aws >/dev/null; then echo "aws CLI required"; exit 1; fi
if ! command -v jq  >/dev/null; then echo "jq required"; exit 1; fi

retry() { local max="${1:-5}"; local base="${2:-1}"; shift 2; local a=1; until "$@"; do rc=$?; [ $a -ge $max ] && return $rc; sleep $(( base * a )); a=$((a+1)); done; }
regions() { aws ec2 describe-regions --query 'Regions[].RegionName' --output text; }

log(){ echo -e "$@"; }
log "🔄 AWS Config Restore (mode: $MODE)"
[ -f backup_metadata.json ] || { echo "Run from backup directory"; exit 1; }

TOTAL=$(jq -r '.total_rules' backup_metadata.json)
log "📊 Backup total rules: $TOTAL"

confirm() { read -p "$1 " ans; [[ "$ans" =~ ^(RESTORE|restore)$ ]]; }
log "⚠️ This will recreate rules from backup. Type RESTORE to continue."
confirm "Type RESTORE to proceed: " || { echo "Cancelled"; exit 1; }

RESTORED=0; FAILED=0; SKIPPED=0
for r in $(regions); do
  f="config_rules_${r}.json"
  [ -f "$f" ] || continue
  COUNT=$(jq '.ConfigRules | length' "$f")
  [ "$COUNT" -gt 0 ] || continue
  log "   • Restoring region: $r ($COUNT rules)"

  for i in $(seq 0 $((COUNT-1))); do
    RULE_JSON=$(jq ".ConfigRules[$i]" "$f")
    NAME=$(jq -r '.ConfigRuleName' <<<"$RULE_JSON")
    OWNER=$(jq -r '.Source.Owner'   <<<"$RULE_JSON")
    SID =$(jq -r '.Source.SourceIdentifier' <<<"$RULE_JSON")
    [ -n "$NAME" ] && [ "$NAME" != "null" ] || continue

    if aws configservice describe-config-rules --config-rule-names "$NAME" --region "$r" >/dev/null 2>&1; then
      SKIPPED=$((SKIPPED+1)); continue
    fi

    if [ "$MODE" = "managed" ] && [ "$OWNER" != "AWS" ]; then
      SKIPPED=$((SKIPPED+1)); continue
    fi

    if [ "$OWNER" = "AWS" ]; then
      # Restore AWS managed rule
      CMD=(aws configservice put-config-rule --region "$r"
           --config-rule "ConfigRuleName=$NAME,Source={Owner=AWS,SourceIdentifier=$SID}")
      if retry 5 1 "${CMD[@]}" >/dev/null 2>&1; then RESTORED=$((RESTORED+1)); else FAILED=$((FAILED+1)); fi
    else
      # Full custom restore uses raw rule JSON (best-effort)
      TMP="/tmp/rule_${r}_${i}.json"; jq '.' <<<"$RULE_JSON" > "$TMP"
      if retry 5 1 aws configservice put-config-rule --region "$r" --config-rule "file://$TMP" >/dev/null 2>&1; then
        RESTORED=$((RESTORED+1))
      else
        FAILED=$((FAILED+1))
      fi
      rm -f "$TMP"
    fi
    sleep 0.3
  done
done

echo ""
echo "🎉 RESTORE COMPLETE"
echo "   Restored: $RESTORED | Failed: $FAILED | Skipped: $SKIPPED"
echo "   Mode used: $MODE"
RESTORE_EOF

chmod +x "$RESTORE_SCRIPT"

# ---------------------- Mode routing (backup/nuclear) -----------------------
if [ "$MODE" = "backup" ]; then
  log "✅ WORKING backup complete at: $BACKUP_DIR"
  log "   Restore with: (cd $BACKUP_DIR && ./$(basename "$RESTORE_SCRIPT") $RESTORE_MODE)"
  exit 0
elif [ "$MODE" != "nuclear" ] && [ "$MODE" != "interactive" ]; then
  echo "❌ --mode must be 'backup' or 'nuclear' (or omit for interactive)"; exit 1
fi

# ------------------- Phase 3: (Interactive) Nuclear Prompt ------------------
if [ "$MODE" = "interactive" ]; then
  echo ""
  echo "⚠️ NUCLEAR DEPLOYMENT OPTIONS"
  echo "   1) NUCLEAR_BACKUP (delete everything)"
  echo "   2) BACKUP_ONLY"
  echo "   3) CANCEL"
  read -p "Choose (1/2/3): " choice
  case "$choice" in
    1) MODE="nuclear" ;;
    2) echo "✅ Backup only. Done."; exit 0;;
    3) echo "Cancelled. Backup at: $BACKUP_DIR"; exit 0;;
    *) echo "Invalid"; exit 1;;
  esac
fi

# -------------------- Phase 4: Security Hub disable first -------------------
disable_securityhub_everywhere() {
  log "🔻 Disabling Security Hub standards in ALL regions…"
  for r in $REGIONS_LIST; do
    log "   • [$r] disable standards"
    retry 5 1 aws securityhub enable-security-hub --region "$r" >/dev/null 2>&1 || true
    ARNS=$(aws securityhub get-enabled-standards --region "$r" \
           --query 'StandardsSubscriptions[].StandardsSubscriptionArn' \
           --output text 2>/dev/null || true)
    if [ -n "${ARNS:-}" ]; then
      retry 5 2 aws securityhub batch-disable-standards --region "$r" \
        --standards-subscription-arns $ARNS >/dev/null 2>&1 || true
    fi
  done
}

delete_conformance_packs() {
  log "🧹 Deleting conformance packs…"
  for r in $REGIONS_LIST; do
    for cp in $(aws configservice describe-conformance-packs --region "$r" \
               --query 'ConformancePackDetails[].ConformancePackName' --output text 2>/dev/null); do
      log "   • [$r] delete conformance pack: $cp"
      retry 5 1 aws configservice delete-conformance-pack --region "$r" \
        --conformance-pack-name "$cp" >/dev/null 2>&1 || true
    done
  done
}

delete_all_rules() {
  log "🧹 Deleting ALL Config rules…"
  for r in $REGIONS_LIST; do
    for rule in $(aws configservice describe-config-rules --region "$r" \
                --query 'ConfigRules[].ConfigRuleName' --output text 2>/dev/null); do
      log "   • [$r] delete rule: $rule"
      retry 5 1 aws configservice delete-config-rule --region "$r" \
        --config-rule-name "$rule" >/dev/null 2>&1 || true
      sleep 0.2
    done
  done
}

stop_and_remove_recorders_channels() {
  log "🛑 Stopping & removing recorders/channels…"
  for r in $REGIONS_LIST; do
    for rec in $(aws configservice describe-configuration-recorders --region "$r" \
               --query 'ConfigurationRecorders[].name' --output text 2>/dev/null); do
      log "   • [$r] stop recorder: $rec"
      retry 5 1 aws configservice stop-configuration-recorder --region "$r" \
        --configuration-recorder-name "$rec" >/dev/null 2>&1 || true
    done
    for ch in $(aws configservice describe-delivery-channels --region "$r" \
               --query 'DeliveryChannels[].name' --output text 2>/dev/null); do
      log "   • [$r] delete delivery channel: $ch"
      retry 5 1 aws configservice delete-delivery-channel --region "$r" \
        --delivery-channel-name "$ch" >/dev/null 2>&1 || true
    done
    for rec in $(aws configservice describe-configuration-recorders --region "$r" \
               --query 'ConfigurationRecorders[].name' --output text 2>/dev/null); do
      log "   • [$r] delete recorder: $rec"
      retry 5 1 aws configservice delete-configuration-recorder --region "$r" \
        --configuration-recorder-name "$rec" >/dev/null 2>&1 || true
    done
  done
}

delete_aggregators() {
  log "🧹 Deleting configuration aggregators…"
  for r in $REGIONS_LIST; do
    for ag in $(aws configservice describe-configuration-aggregators --region "$r" \
              --query 'ConfigurationAggregators[].ConfigurationAggregatorName' --output text 2>/dev/null); do
      log "   • [$r] delete aggregator: $ag"
      retry 5 1 aws configservice delete-configuration-aggregator --region "$r" \
        --configuration-aggregator-name "$ag" >/dev/null 2>&1 || true
    done
  done
}

count_rules_all_regions() {
  local total=0
  for r in $REGIONS_LIST; do
    c=$(aws configservice describe-config-rules --region "$r" --query 'length(ConfigRules)' --output text 2>/dev/null || echo 0)
    total=$(( total + c ))
  done
  echo "$total"
}

# --------------------------- Phase 5: Nuclear Run ---------------------------
if [ "$MODE" = "nuclear" ]; then
  echo ""
  echo "⚠️ FINAL WARNING: This will DELETE ALL Config artifacts account-wide."
  if [ "$ASSUME_YES" != "true" ]; then
    read -p "Type NUCLEAR to proceed: " c; [ "$c" = "NUCLEAR" ] || { echo "Cancelled. Backup at: $BACKUP_DIR"; exit 1; }
  fi

  log "☢️ Executing Nuclear Cleanup…"
  disable_securityhub_everywhere
  delete_conformance_packs
  delete_all_rules
  stop_and_remove_recorders_channels
  delete_aggregators

  REMAIN=$(count_rules_all_regions)
  STATUS=$([ "$REMAIN" -eq 0 ] && echo "✅ Complete success" || echo "⚠️ Partial — manual follow-up")
  log "📊 Remaining rules after cleanup: $REMAIN  |  Status: $STATUS"

  # summary artifacts
  echo "{\"client\":\"$CLIENT_CODE\",\"completed\":\"$(date -Iseconds)\",\"remaining_rules\":$REMAIN,\"status\":\"$STATUS\",\"backup_dir\":\"$BACKUP_DIR\"}" \
    > "${CLIENT_CODE}_NUCLEAR_REPORT_${NOW}.json"
  cat > "${CLIENT_CODE}_NUCLEAR_REPORT_${NOW}.txt" <<TXT
NUCLEAR CLEANUP SUMMARY
Client: $CLIENT_CODE
Completed: $(date)
Backup Dir: $BACKUP_DIR
Remaining Rules: $REMAIN
Status: $STATUS
Restore: cd $BACKUP_DIR && ./$(basename "$RESTORE_SCRIPT") $RESTORE_MODE
TXT

  log "✅ Nuclear cleanup complete. Reports: ${CLIENT_CODE}_NUCLEAR_REPORT_${NOW}.{json,txt}"
  log "🔄 Restore when ready: cd $BACKUP_DIR && ./$(basename "$RESTORE_SCRIPT") $RESTORE_MODE"
fi
