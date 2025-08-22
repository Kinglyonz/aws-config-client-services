#!/bin/bash
# AWS Config Complete Nuke Service - EMERGENCY/ADVANCED OPTION
# PRIVATE REPOSITORY - For specific client requests only
# Contact: khalillyons@gmail.com | (703) 795-4193
# 
# WARNING: This deletes ALL Config rules without discrimination
# Use intelligent cleanup (client-service.sh) for normal operations

CLIENT_CODE="$1"
if [ -z "$CLIENT_CODE" ]; then
    echo "❌ Authorization required for nuclear cleanup option."
    echo "📞 Contact: khalillyons@gmail.com | (703) 795-4193"
    echo ""
    echo "💡 For normal cleanup, use: ./client-service.sh CLIENT_CODE"
    echo "   (Preserves SecurityHub rules and provides intelligent cleanup)"
    exit 1
fi

echo "☢️  AWS Config COMPLETE NUKE Service"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Client Code: $CLIENT_CODE"
echo "Service Date: $(date)"
echo "Service Provider: AWS Config Cleanup Service"
echo "Contact: khalillyons@gmail.com | (703) 795-4193"
echo ""
echo "⚠️  WARNING: NUCLEAR OPTION SELECTED"
echo "   This will delete ALL Config rules including SecurityHub"
echo "   Consider using intelligent cleanup instead: ./client-service.sh"
echo ""

# Get current rule count
echo "🔍 Phase 1: Pre-nuke Discovery"
echo "   Discovering all Config rules across regions..."

TOTAL_RULES=0
REGIONS=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

for region in $REGIONS; do
    echo "   Scanning region: $region"
    REGION_RULES=$(aws configservice describe-config-rules --region $region --query 'ConfigRules[].ConfigRuleName' --output text 2>/dev/null | wc -w)
    TOTAL_RULES=$((TOTAL_RULES + REGION_RULES))
done

echo "   Total Config rules found: $TOTAL_RULES"
echo ""

# Calculate pricing for nuke service
NUKE_PRICE=$((TOTAL_RULES * 3))
if [ $NUKE_PRICE -lt 500 ]; then
    NUKE_PRICE=500
elif [ $NUKE_PRICE -gt 2500 ]; then
    NUKE_PRICE=2500
fi

echo "💰 Phase 2: Nuclear Service Pricing"
echo "   Rules to be deleted: $TOTAL_RULES"
echo "   Service investment: \$$NUKE_PRICE"
echo "   ⚠️  Includes SecurityHub rules (will be deleted)"
echo "   💡 Alternative: Intelligent cleanup preserves SecurityHub"
echo ""

echo "⚠️  FINAL WARNING - POINT OF NO RETURN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   This will delete ALL $TOTAL_RULES Config rules"
echo "   INCLUDING beneficial AWS-managed SecurityHub rules"
echo "   Your security monitoring will be DISABLED"
echo ""
echo "   Alternative options:"
echo "   1. ./client-service.sh $CLIENT_CODE (intelligent cleanup)"
echo "   2. Cancel and contact support for consultation"
echo ""

read -p "   Type 'NUCLEAR' to proceed with complete deletion: " confirmation

if [ "$confirmation" != "NUCLEAR" ]; then
    echo "❌ Nuclear cleanup cancelled"
    echo ""
    echo "💡 Recommended alternatives:"
    echo "   • Intelligent cleanup: ./client-service.sh $CLIENT_CODE"
    echo "   • Consultation: khalillyons@gmail.com | (703) 795-4193"
    exit 1
fi

echo ""
echo "☢️  Phase 3: Nuclear Cleanup Execution"
echo "   Start time: $(date)"
echo "   Executing complete Config rule deletion..."
echo ""

# Execute nuclear cleanup across all regions
DELETED_COUNT=0
for region in $REGIONS; do
    echo "   Processing region: $region"
    
    # Get all rules in this region
    RULES=$(aws configservice describe-config-rules --region $region --query 'ConfigRules[].ConfigRuleName' --output text 2>/dev/null)
    
    if [ -n "$RULES" ]; then
        for rule in $RULES; do
            echo "     Deleting: $rule"
            aws configservice delete-config-rule --config-rule-name "$rule" --region $region 2>/dev/null
            
            if [ $? -eq 0 ]; then
                DELETED_COUNT=$((DELETED_COUNT + 1))
            else
                echo "     ⚠️  Failed to delete: $rule"
            fi
        done
    fi
done

COMPLETION_TIME=$(date)

echo ""
echo "☢️  Phase 4: Nuclear Cleanup Validation"
echo "   Completion time: $COMPLETION_TIME"
echo "   Rules deleted: $DELETED_COUNT"
echo "   Original count: $TOTAL_RULES"

# Verify cleanup
echo "   Verifying complete deletion..."
REMAINING_RULES=0
for region in $REGIONS; do
    REGION_REMAINING=$(aws configservice describe-config-rules --region $region --query 'ConfigRules[].ConfigRuleName' --output text 2>/dev/null | wc -w)
    REMAINING_RULES=$((REMAINING_RULES + REGION_REMAINING))
done

echo "   Remaining rules: $REMAINING_RULES"

if [ $REMAINING_RULES -eq 0 ]; then
    echo "✅ Nuclear cleanup completed successfully"
else
    echo "⚠️  Some rules may remain - manual cleanup required"
fi

# Generate nuclear service documentation
echo ""
echo "📄 Phase 5: Nuclear Service Documentation"

cat > "NUCLEAR_${CLIENT_CODE}_Service_Complete.txt" << EOF
AWS CONFIG NUCLEAR CLEANUP SERVICE - COMPLETION SUMMARY
======================================================

CLIENT INFORMATION
------------------
Client Code: $CLIENT_CODE
Service Date: $(date +"%Y-%m-%d")
Service Type: Complete Nuclear Cleanup
Service Provider: AWS Config Cleanup Service
Contact: khalillyons@gmail.com | (703) 795-4193

NUCLEAR CLEANUP RESULTS
-----------------------
• Original Config Rules: $TOTAL_RULES
• Rules Deleted: $DELETED_COUNT
• Remaining Rules: $REMAINING_RULES
• Cleanup Duration: $COMPLETION_TIME

⚠️  IMPORTANT NOTES
------------------
• ALL Config rules deleted (including SecurityHub)
• Security monitoring DISABLED
• No rule discrimination applied
• Complete nuclear cleanup executed

BILLING INFORMATION
-------------------
Service: AWS Config Nuclear Cleanup
Rules processed: $TOTAL_RULES
Final Investment: \$$NUKE_PRICE

NEXT STEPS
----------
Your AWS environment is now completely clean of Config rules.

To restore security monitoring:
1. Re-enable SecurityHub in AWS Console
2. Consider NIST 800-171 deployment for compliance:
   ./nist-deployment-service.sh $CLIENT_CODE NIST-Stack

SUPPORT
-------
Email: khalillyons@gmail.com
Phone: (703) 795-4193
Service completed: $(date)
EOF

echo ""
echo "☢️  NUCLEAR CLEANUP SERVICE COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Final Results:"
echo "   • Original rules: $TOTAL_RULES"
echo "   • Deleted rules: $DELETED_COUNT"
echo "   • Remaining rules: $REMAINING_RULES"
echo ""
echo "⚠️  IMPORTANT: All security monitoring disabled"
echo "   Consider re-enabling SecurityHub or deploying NIST compliance"
echo ""
echo "📄 Documentation: NUCLEAR_${CLIENT_CODE}_Service_Complete.txt"
echo ""
echo "📞 Support: khalillyons@gmail.com | (703) 795-4193"
echo ""
echo "💼 Nuclear cleanup service complete."
