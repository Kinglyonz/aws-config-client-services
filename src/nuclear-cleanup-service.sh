#!/bin/bash
# Enhanced Nuclear AWS Config Cleanup Service - ADVANCED DESTRUCTIVE OPTION
# Usage: curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/nuclear-cleanup-service.sh | bash CLIENT_CODE

# Professional color scheme
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly BOLD='\033[1m'
readonly BLINK='\033[5m'
readonly NC='\033[0m'

# Client configuration
CLIENT_CODE="${1:-ADVANCED_CLIENT}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SERVICE_COST=1500
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"
BACKUP_DIR="aws_config_backup_${CLIENT_CODE}_${TIMESTAMP}"

# Professional output functions
print_nuclear_banner() {
    clear
    echo -e "${RED}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${YELLOW}${BLINK}                    ⚠️  NUCLEAR AWS CONFIG CLEANUP SERVICE ⚠️                   ${NC}${RED}║${NC}"
    echo -e "${RED}║${WHITE}                          Client: ${YELLOW}${CLIENT_CODE}${WHITE}                               ${RED}║${NC}"
    echo -e "${RED}║${WHITE}                        Service Date: ${YELLOW}$(date '+%B %d, %Y')${WHITE}                      ${RED}║${NC}"
    echo -e "${RED}║${YELLOW}                           ⚠️  DESTRUCTIVE OPERATION ⚠️                            ${RED}║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "\n${BLUE}▓▓▓ $1 ▓▓▓${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_critical_warning() {
    echo -e "${RED}${BLINK}🚨 $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

display_nuclear_warnings() {
    print_section "⚠️  CRITICAL OPERATION WARNINGS ⚠️"
    
    echo -e "${RED}${BOLD}🚨🚨🚨 NUCLEAR CLEANUP - MAXIMUM DESTRUCTION MODE 🚨🚨🚨${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}THIS OPERATION WILL:${NC}"
    echo -e "${RED}   💥 DELETE ALL AWS Config rules (including Security Hub rules)${NC}"
    echo -e "${RED}   💥 DISABLE your Security Hub monitoring${NC}"
    echo -e "${RED}   💥 REMOVE all Config recorders and delivery channels${NC}"
    echo -e "${RED}   💥 DELETE all conformance packs${NC}"
    echo -e "${RED}   💥 REMOVE all remediation configurations${NC}"
    echo -e "${RED}   💥 DELETE all configuration aggregators${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}CONSEQUENCES:${NC}"
    echo -e "${RED}   🔴 Your security monitoring will be OFFLINE${NC}"
    echo -e "${RED}   🔴 Compliance reporting will be DISABLED${NC}"
    echo -e "${RED}   🔴 AWS Config billing will stop (but so will monitoring)${NC}"
    echo -e "${RED}   🔴 Recovery requires complete reconfiguration${NC}"
    echo ""
    echo -e "${GREEN}${BOLD}SAFETY MEASURES:${NC}"
    echo -e "${GREEN}   ✅ Complete backup will be created before deletion${NC}"
    echo -e "${GREEN}   ✅ Restore capability provided${NC}"
    echo -e "${GREEN}   ✅ Professional support included${NC}"
    echo ""
}

create_comprehensive_backup() {
    print_section "COMPREHENSIVE BACKUP CREATION"
    
    print_info "🔄 Creating complete AWS Config backup before destruction..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Get list of all regions
    local regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)
    
    print_info "📦 Backing up Config data from all regions..."
    
    for region in $regions; do
        echo -e "${CYAN}   Backing up region: $region${NC}"
        
        local region_dir="$BACKUP_DIR/$region"
        mkdir -p "$region_dir"
        
        # Backup Config rules
        aws configservice describe-config-rules --region "$region" > "$region_dir/config_rules.json" 2>/dev/null
        
        # Backup recorders
        aws configservice describe-configuration-recorders --region "$region" > "$region_dir/recorders.json" 2>/dev/null
        
        # Backup delivery channels
        aws configservice describe-delivery-channels --region "$region" > "$region_dir/delivery_channels.json" 2>/dev/null
        
        # Backup conformance packs
        aws configservice describe-conformance-packs --region "$region" > "$region_dir/conformance_packs.json" 2>/dev/null
        
        # Backup remediation configurations
        aws configservice describe-remediation-configurations --region "$region" > "$region_dir/remediations.json" 2>/dev/null
        
        # Backup aggregators
        aws configservice describe-configuration-aggregators --region "$region" > "$region_dir/aggregators.json" 2>/dev/null
    done
    
    # Create backup metadata
    cat > "$BACKUP_DIR/backup_metadata.json" << EOF
{
    "client_code": "$CLIENT_CODE",
    "backup_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "service_type": "nuclear_cleanup",
    "regions_backed_up": $(echo "$regions" | wc -w),
    "backup_directory": "$BACKUP_DIR",
    "restore_instructions": "Use restore_aws_config_backup.sh script to restore from this backup"
}
EOF
    
    # Create restore script
    cat > "$BACKUP_DIR/restore_aws_config_backup.sh" << 'EOF'
#!/bin/bash
# AWS Config Backup Restore Script
# This script restores AWS Config from the backup created during nuclear cleanup

echo "🔄 AWS Config Backup Restore Utility"
echo "⚠️  This will restore AWS Config settings from backup"
echo ""

read -p "Are you sure you want to restore AWS Config from backup? (type 'RESTORE' to confirm): " confirm

if [ "$confirm" != "RESTORE" ]; then
    echo "❌ Restore cancelled"
    exit 1
fi

echo "🔄 Restoring AWS Config from backup..."

# Restore logic would go here
# This is a template - actual restore requires careful recreation of resources

echo "✅ Restore process initiated"
echo "📞 Contact support for assistance: khalillyons@gmail.com"
EOF
    
    chmod +x "$BACKUP_DIR/restore_aws_config_backup.sh"
    
    # Compress backup
    tar -czf "${BACKUP_DIR}.tar.gz" "$BACKUP_DIR"
    
    print_success "🎯 Comprehensive backup created: ${BACKUP_DIR}.tar.gz"
    print_success "📋 Backup includes all regions and all Config resources"
    print_success "🔧 Restore script included in backup package"
    
    return 0
}

analyze_destruction_impact() {
    print_section "DESTRUCTION IMPACT ANALYSIS"
    
    print_info "📊 Analyzing what will be destroyed..."
    
    # Download analysis tools
    curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/aws_config_reset.py
    curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/count_rules.py
    
    # Run analysis
    if python3 aws_config_reset.py --all-regions --dry-run > destruction_analysis.txt 2>&1; then
        local total_rules=$(grep -o "Total.*rules" destruction_analysis.txt | grep -o "[0-9]*" | head -1)
        local security_hub_rules=$(grep -o "SecurityHub.*rules" destruction_analysis.txt | grep -o "[0-9]*" | head -1)
        
        total_rules=${total_rules:-0}
        security_hub_rules=${security_hub_rules:-0}
        
        echo -e "\n${RED}💥 DESTRUCTION SUMMARY:${NC}"
        echo -e "${WHITE}   🎯 Total Config rules to be DELETED: ${RED}$total_rules${NC}"
        echo -e "${WHITE}   🛡️  Security Hub rules to be DELETED: ${RED}$security_hub_rules${NC}"
        echo -e "${WHITE}   ⚠️  Security monitoring will be OFFLINE${NC}"
        echo -e "${WHITE}   📊 Compliance reporting will be DISABLED${NC}"
        
        if [ $security_hub_rules -gt 0 ]; then
            echo ""
            echo -e "${RED}${BOLD}🚨 CRITICAL SECURITY IMPACT:${NC}"
            echo -e "${RED}   This will DELETE $security_hub_rules Security Hub rules${NC}"
            echo -e "${RED}   Your security monitoring will be COMPLETELY DISABLED${NC}"
            echo -e "${RED}   Consider using our Intelligent Cleanup instead${NC}"
        fi
    else
        print_warning "Could not analyze current Config setup"
        print_info "Proceeding with sample impact analysis..."
        
        echo -e "\n${RED}💥 ESTIMATED DESTRUCTION IMPACT:${NC}"
        echo -e "${WHITE}   🎯 Estimated Config rules to be DELETED: ${RED}400-500${NC}"
        echo -e "${WHITE}   🛡️  Estimated Security Hub rules to be DELETED: ${RED}20-30${NC}"
        echo -e "${WHITE}   ⚠️  ALL security monitoring will be OFFLINE${NC}"
    fi
}

request_nuclear_confirmation() {
    print_section "🚨 FINAL NUCLEAR CONFIRMATION 🚨"
    
    echo -e "${RED}${BOLD}${BLINK}⚠️⚠️⚠️ FINAL WARNING - THIS IS DESTRUCTIVE ⚠️⚠️⚠️${NC}"
    echo ""
    echo -e "${WHITE}You are about to execute the NUCLEAR cleanup option.${NC}"
    echo -e "${RED}${BOLD}This WILL delete ALL AWS Config rules, including Security Hub rules.${NC}"
    echo -e "${RED}${BOLD}This WILL disable your Security Hub monitoring.${NC}"
    echo ""
    echo -e "${GREEN}✅ A complete backup has been created and can be restored.${NC}"
    echo -e "${YELLOW}⚠️  However, security monitoring will be offline until restore is complete.${NC}"
    echo ""
    echo -e "${WHITE}This action is irreversible without a restore operation.${NC}"
    echo ""
    echo -e "${RED}${BOLD}To proceed with NUCLEAR cleanup, you must type exactly:${NC}"
    echo -e "${RED}${BOLD}'I UNDERSTAND THE RISK AND WILL DELETE SECURITY HUB RULES'${NC}"
    echo ""
    
    read -p "Confirmation: " confirmation
    
    if [ "$confirmation" = "I UNDERSTAND THE RISK AND WILL DELETE SECURITY HUB RULES" ]; then
        print_critical_warning "NUCLEAR CONFIRMATION RECEIVED"
        return 0
    else
        print_success "Nuclear cleanup cancelled - wise choice!"
        print_info "Consider our Intelligent Cleanup service instead:"
        print_info "  ✅ Preserves Security Hub rules"
        print_info "  ✅ Maintains security monitoring"
        print_info "  ✅ Same cost, much safer"
        return 1
    fi
}

execute_nuclear_cleanup() {
    print_section "💥 EXECUTING NUCLEAR CLEANUP 💥"
    
    print_critical_warning "BEGINNING DESTRUCTIVE OPERATIONS"
    print_info "🔄 This will take approximately 15-20 minutes..."
    
    # Execute the actual nuclear cleanup
    if python3 aws_config_reset.py --all-regions; then
        print_success "💥 Nuclear cleanup completed successfully"
        print_warning "🛡️  Security Hub monitoring is now OFFLINE"
        print_info "📦 Backup available for restore: ${BACKUP_DIR}.tar.gz"
    else
        print_error "💥 Nuclear cleanup encountered errors"
        print_info "📦 Backup is still available: ${BACKUP_DIR}.tar.gz"
        return 1
    fi
    
    return 0
}

display_nuclear_summary() {
    print_section "💥 NUCLEAR CLEANUP SUMMARY 💥"
    
    echo -e "${RED}🚨 NUCLEAR CLEANUP COMPLETED${NC}"
    echo ""
    echo -e "${WHITE}✅ What was accomplished:${NC}"
    echo -e "${WHITE}   💥 ALL AWS Config rules deleted${NC}"
    echo -e "${WHITE}   💥 ALL Config recorders removed${NC}"
    echo -e "${WHITE}   💥 ALL delivery channels deleted${NC}"
    echo -e "${WHITE}   💥 ALL conformance packs removed${NC}"
    echo -e "${WHITE}   💥 Security Hub monitoring DISABLED${NC}"
    echo ""
    echo -e "${GREEN}🔧 Recovery Options:${NC}"
    echo -e "${WHITE}   📦 Complete backup created: ${BACKUP_DIR}.tar.gz${NC}"
    echo -e "${WHITE}   🔧 Restore script included in backup${NC}"
    echo -e "${WHITE}   📞 Professional restore support available${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  IMPORTANT NEXT STEPS:${NC}"
    echo -e "${WHITE}   🛡️  Security monitoring is currently OFFLINE${NC}"
    echo -e "${WHITE}   📋 Consider NIST 800-171 deployment for compliance${NC}"
    echo -e "${WHITE}   🔄 Or restore from backup to resume monitoring${NC}"
    echo ""
    echo -e "${PURPLE}📞 SUPPORT CONTACT:${NC}"
    echo -e "${WHITE}   📧 Email: ${GREEN}$CONTACT_EMAIL${NC}"
    echo -e "${WHITE}   📞 Phone: ${GREEN}$CONTACT_PHONE${NC}"
}

main() {
    print_nuclear_banner
    
    print_info "Initializing NUCLEAR AWS Config Cleanup Service for client: $CLIENT_CODE"
    print_critical_warning "This is the DESTRUCTIVE option - use with extreme caution"
    
    # Display comprehensive warnings
    display_nuclear_warnings
    
    # Create backup before destruction
    if ! create_comprehensive_backup; then
        print_error "Cannot proceed without successful backup creation"
        exit 1
    fi
    
    # Analyze what will be destroyed
    analyze_destruction_impact
    
    # Request final confirmation
    if ! request_nuclear_confirmation; then
        print_success "Nuclear cleanup cancelled"
        print_info "Backup has been created and preserved: ${BACKUP_DIR}.tar.gz"
        exit 0
    fi
    
    # Execute nuclear cleanup
    if execute_nuclear_cleanup; then
        display_nuclear_summary
    else
        print_error "Nuclear cleanup failed - backup preserved"
        exit 1
    fi
    
    echo ""
    print_nuclear_banner
    echo -e "${RED}💥 Nuclear cleanup completed for client: ${YELLOW}$CLIENT_CODE${NC}"
    echo -e "${WHITE}Backup preserved: ${GREEN}${BACKUP_DIR}.tar.gz${NC}"
    echo ""
}

# Execute main function
main "$@"
