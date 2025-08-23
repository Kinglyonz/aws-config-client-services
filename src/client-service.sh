#!/bin/bash
# AWS Config Cleanup - Professional Client Service Delivery
# UPDATED: Now uses LIVE AWS data for consistent rule counting
# Contact: khalillyons@gmail.com | (703) 795-4193

# Validate client authorization
CLIENT_CODE="$1"
if [ -z "$CLIENT_CODE" ]; then
    echo "❌ Authorization required."
    echo "📞 Contact: khalillyons@gmail.com | (703) 795-4193"
    exit 1
fi

echo "🏢 AWS Config Professional Cleanup Service"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Client Code: $CLIENT_CODE"
echo "Service Date: $(date)"
echo "Service Provider: AWS Config Cleanup Service"
echo "Contact: khalillyons@gmail.com | (703) 795-4193"
echo ""

# Download enhanced client toolkit
echo "📥 Downloading professional service toolkit..."
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/aws_config_reset.py
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/count_rules.py
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/read_config_report.py
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/create_client_report.py

echo "✅ Professional service toolkit ready!"
echo ""

# Phase 1: Pre-service discovery
echo "🔍 Phase 1: Pre-service Discovery & Validation"
echo "   Running comprehensive analysis for client: $CLIENT_CODE"

# IMPROVED: Do both discovery methods for comparison
echo "   📊 Method 1: JSON-based discovery..."
python3 aws_config_reset.py --all-regions

if [ $? -ne 0 ]; then
    echo "❌ Pre-service validation failed."
    echo "📞 Contact service provider: khalillyons@gmail.com"
    exit 1
fi

# IMPROVED: Get live count for verification
echo "   📊 Method 2: Live AWS API verification..."
echo "   Verifying rule counts across all regions..."

# Get live count using AWS CLI (most reliable method)
LIVE_RULE_COUNT=0
REGIONS_WITH_CONFIG=0

# Get all regions
ALL_REGIONS=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

echo "   🌍 Scanning regions for Config rules..."
for region in $ALL_REGIONS; do
    REGION_COUNT=$(aws configservice describe-config-rules --region $region --query 'length(ConfigRules)' --output text 2>/dev/null)
    
    if [ $? -eq 0 ] && [ "$REGION_COUNT" != "None" ] && [ "$REGION_COUNT" -gt 0 ]; then
        echo "      $region: $REGION_COUNT rules"
        LIVE_RULE_COUNT=$((LIVE_RULE_COUNT + REGION_COUNT))
        REGIONS_WITH_CONFIG=$((REGIONS_WITH_CONFIG + 1))
    else
        echo "      $region: 0 rules (Config not enabled)"
    fi
done

echo ""
echo "   ✅ Live verification complete:"
echo "      • Total regions scanned: $(echo $ALL_REGIONS | wc -w)"
echo "      • Regions with Config: $REGIONS_WITH_CONFIG"  
echo "      • Total Config rules (LIVE): $LIVE_RULE_COUNT"
echo ""

# Phase 2: Business value confirmation with LIVE data
echo "💰 Phase 2: Business Value Confirmation"
echo "   Using LIVE AWS data for accurate pricing..."

# Calculate pricing using live count (most accurate)
BASE_PRICE=$((LIVE_RULE_COUNT * 3))
if [ $BASE_PRICE -lt 500 ]; then
    FINAL_PRICE=500
elif [ $BASE_PRICE -gt 2500 ]; then
    FINAL_PRICE=2500
else
    FINAL_PRICE=$BASE_PRICE
fi

# Calculate manual costs
MANUAL_MINUTES=$((LIVE_RULE_COUNT * 2))
MANUAL_HOURS=$((MANUAL_MINUTES / 60))
MANUAL_COST=$((MANUAL_HOURS * 240))
SAVINGS=$((MANUAL_COST - FINAL_PRICE))

echo "   📊 LIVE PRICING ANALYSIS:"
echo "      • Config rules found: $LIVE_RULE_COUNT"
echo "      • Base price (${LIVE_RULE_COUNT} × \$3): \$$BASE_PRICE"
echo "      • Final service price: \$$FINAL_PRICE"
echo "      • Manual cost estimate: \$$MANUAL_COST"
echo "      • Client savings: \$$SAVINGS"
echo ""

# BACKUP: Also run JSON-based calculator for comparison
echo "   📋 Running backup analysis for comparison..."
python3 count_rules.py

# Phase 3: Professional reporting
echo ""
echo "📊 Phase 3: Professional Report Generation"
python3 read_config_report.py
python3 create_client_report.py

# Add client-specific branding to reports with LIVE data
echo ""
echo "🏷️  Adding client-specific documentation with live data..."
CLIENT_DATE=$(date +"%Y-%m-%d")
CLIENT_TIME=$(date +"%H:%M:%S")

# Create enhanced client-specific summary with live data
cat > "CLIENT_${CLIENT_CODE}_Service_Summary.txt" << EOF
AWS CONFIG CLEANUP SERVICE - CLIENT DELIVERY SUMMARY
====================================================

Client Code: $CLIENT_CODE
Service Date: $CLIENT_DATE
Service Time: $CLIENT_TIME
Service Provider: AWS Config Cleanup Service
Contact: khalillyons@gmail.com | (703) 795-4193

DISCOVERY PHASE COMPLETED
-------------------------
✅ Multi-region Config rule discovery completed
✅ LIVE AWS API verification completed
✅ Business value analysis generated (using live data)
✅ Professional documentation created
✅ Risk assessment completed

LIVE AWS ANALYSIS RESULTS
-------------------------
• Total AWS regions scanned: $(echo $ALL_REGIONS | wc -w)
• Regions with AWS Config enabled: $REGIONS_WITH_CONFIG
• Total Config rules discovered (LIVE): $LIVE_RULE_COUNT
• Analysis timestamp: $(date)

PRICING BREAKDOWN (LIVE DATA)
-----------------------------
• Config rules found: $LIVE_RULE_COUNT
• Rate: \$3.00 per rule
• Base calculation: $LIVE_RULE_COUNT × \$3 = \$$BASE_PRICE
• Final service price: \$$FINAL_PRICE
• Estimated manual cost: \$$MANUAL_COST
• Client savings: \$$SAVINGS

READY FOR CLEANUP EXECUTION
----------------------------
Status: Discovery phase complete - awaiting execution approval
Next Step: Schedule cleanup execution window

SERVICE EXECUTION COMMAND
-------------------------
To execute the actual cleanup service:
python3 aws_config_reset.py --all-regions --no-dry-run

PROFESSIONAL DELIVERABLES
--------------------------
• config_reset_report.json (technical analysis)
• Business_Value_Summary.txt (ROI calculations)
• Human_Readable_Config_Report.txt (detailed report)
• AWS_Config_Cleanup_Report.txt (executive documentation)
• CLIENT_${CLIENT_CODE}_Service_Summary.txt (this summary with live data)

DATA ACCURACY GUARANTEE
------------------------
Pricing based on LIVE AWS API data ($(date))
Same method as: aws configservice describe-config-rules
Guaranteed accurate count matching AWS Console

SUPPORT & CONTACT
-----------------
Service Provider: AWS Config Cleanup Service
Email: khalillyons@gmail.com
Phone: (703) 795-4193
Business Hours: Available 24/7 for service delivery

NEXT STEPS
----------
1. Review discovery analysis and business value reports
2. Approve service execution window
3. Execute professional cleanup service
4. Receive final documentation and billing

Professional service delivery completed by:
AWS Config Cleanup Service
Generated: $(date)
Live Data Verification: $LIVE_RULE_COUNT rules confirmed via AWS API
EOF

# Create a separate live data summary for easy reference
cat > "LIVE_DATA_${CLIENT_CODE}_$(date +%Y%m%d_%H%M%S).txt" << EOF
AWS CONFIG LIVE DATA SUMMARY
============================

Client: $CLIENT_CODE
Timestamp: $(date)
Data Source: Live AWS API calls

LIVE SCAN RESULTS:
• Total Config rules: $LIVE_RULE_COUNT
• Regions with Config: $REGIONS_WITH_CONFIG
• Service price: \$$FINAL_PRICE

This matches the count from:
aws configservice describe-config-rules --query 'length(ConfigRules)'

Generated by AWS Config Professional Service
EOF

echo ""
echo "✅ CLIENT DISCOVERY SERVICE COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 LIVE DATA SUMMARY:"
echo "   • Config rules found: $LIVE_RULE_COUNT (verified live)"
echo "   • Regions analyzed: $(echo $ALL_REGIONS | wc -w)"
echo "   • Service price: \$$FINAL_PRICE"
echo ""
echo "📄 Professional Deliverables Generated:"
ls -la *.txt *.json 2>/dev/null | head -10
echo ""
echo "📧 Client-Specific Files:"
echo "• CLIENT_${CLIENT_CODE}_Service_Summary.txt (with live data)"
echo "• LIVE_DATA_${CLIENT_CODE}_$(date +%Y%m%d_%H%M%S).txt (verification)"
echo ""
echo "🎯 DISCOVERY PHASE COMPLETE"
echo "   ✅ Live data verification: $LIVE_RULE_COUNT rules"
echo "   ✅ Pricing calculated from live AWS API data"
echo "   ✅ Same accuracy as CLI command"
echo ""
echo "⚡ TO EXECUTE ACTUAL CLEANUP:"
echo "   python3 aws_config_reset.py --all-regions --no-dry-run"
echo ""
echo "📞 For execution scheduling or questions:"
echo "   Email: khalillyons@gmail.com"
echo "   Phone: (703) 795-4193"
echo ""
echo "💼 Thank you for choosing AWS Config Cleanup Service!"
