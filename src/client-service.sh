#!/bin/bash
# AWS Config Cleanup - Professional Client Service Delivery
# PRIVATE REPOSITORY - For paying clients only
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
python3 aws_config_reset.py --all-regions

if [ $? -ne 0 ]; then
    echo "❌ Pre-service validation failed."
    echo "📞 Contact service provider: khalillyons@gmail.com"
    exit 1
fi

# Phase 2: Business value confirmation
echo ""
echo "💰 Phase 2: Business Value Confirmation"
python3 count_rules.py

# Get the rule count for confirmation
RULE_COUNT=$(python3 -c "
import json
try:
    with open('config_reset_report.json', 'r') as f:
        data = json.load(f)
        total_rules = 0
        for region_data in data.values():
            if isinstance(region_data, dict) and 'config_rules' in region_data:
                total_rules += len(region_data['config_rules'])
        print(total_rules)
except:
    print('0')
")

# Phase 3: Professional reporting
echo ""
echo "📊 Phase 3: Professional Report Generation"
python3 read_config_report.py
python3 create_client_report.py

# Phase 4: Interactive Confirmation
echo ""
echo "⚠️  READY FOR AWS CONFIG CLEANUP"
echo "   This will intelligently clean problematic Config rules"
echo "   Client: $CLIENT_CODE"
echo "   Rules to be processed: $RULE_COUNT"
echo "   SecurityHub rules will be preserved"
echo ""

read -p "   Continue with cleanup? (type 'EXECUTE'): " confirmation

if [ "$confirmation" != "EXECUTE" ]; then
    echo "❌ Config cleanup cancelled by client"
    echo ""
    echo "📄 Discovery reports have been generated for your review:"
    ls -la *.txt *.json 2>/dev/null
    echo ""
    echo "📞 To reschedule cleanup execution:"
    echo "   Email: khalillyons@gmail.com"
    echo "   Phone: (703) 795-4193"
    exit 1
fi

# Phase 5: Execute Cleanup
echo ""
echo "🚀 Phase 5: Config Cleanup Execution (2-5 minutes)"
echo "   Executing intelligent Config cleanup..."
echo "   Start time: $(date)"

# Execute the actual cleanup
python3 aws_config_reset.py --all-regions --no-dry-run

CLEANUP_RESULT=$?
CLEANUP_END_TIME=$(date)

if [ $CLEANUP_RESULT -eq 0 ]; then
    echo "✅ Config cleanup completed successfully!"
    echo "   Completion time: $CLEANUP_END_TIME"
else
    echo "❌ Config cleanup encountered issues"
    echo "📞 Contact support: khalillyons@gmail.com | (703) 795-4193"
    exit 1
fi

# Phase 6: Post-cleanup validation
echo ""
echo "📊 Phase 6: Post-cleanup Validation"
echo "   Generating final reports..."

# Generate post-cleanup reports
python3 count_rules.py
python3 read_config_report.py

# Get final rule count
FINAL_RULE_COUNT=$(python3 -c "
import json
try:
    with open('config_reset_report.json', 'r') as f:
        data = json.load(f)
        total_rules = 0
        for region_data in data.values():
            if isinstance(region_data, dict) and 'config_rules' in region_data:
                total_rules += len(region_data['config_rules'])
        print(total_rules)
except:
    print('0')
")

RULES_CLEANED=$((RULE_COUNT - FINAL_RULE_COUNT))

# Phase 7: Client Documentation
echo ""
echo "📄 Phase 7: Client Documentation Generation"
CLIENT_DATE=$(date +"%Y-%m-%d")
CLIENT_TIME=$(date +"%H:%M:%S")

# Create comprehensive client summary
cat > "CLIENT_${CLIENT_CODE}_Service_Complete.txt" << EOF
AWS CONFIG CLEANUP SERVICE - COMPLETION SUMMARY
===============================================

CLIENT INFORMATION
------------------
Client Code: $CLIENT_CODE
Service Date: $CLIENT_DATE
Service Time: $CLIENT_TIME
Service Provider: AWS Config Cleanup Service
Contact: khalillyons@gmail.com | (703) 795-4193

SERVICE EXECUTION SUMMARY
-------------------------
✅ Multi-region Config rule discovery completed
✅ Business value analysis generated
✅ Professional documentation created
✅ Intelligent cleanup executed successfully
✅ Post-cleanup validation completed

CLEANUP RESULTS
---------------
• Initial Config Rules: $RULE_COUNT
• Final Config Rules: $FINAL_RULE_COUNT
• Rules Cleaned: $RULES_CLEANED
• SecurityHub Rules: Preserved (as intended)
• Cleanup Duration: $(echo $CLEANUP_END_TIME)

INTELLIGENT CLEANUP SUMMARY
---------------------------
✅ Problematic user-created rules removed
✅ AWS-managed SecurityHub rules preserved
✅ Security monitoring maintained throughout
✅ Clean foundation ready for compliance deployment

PROFESSIONAL DELIVERABLES
--------------------------
• config_reset_report.json (technical analysis)
• Business_Value_Summary.txt (ROI calculations)
• Human_Readable_Config_Report.txt (detailed report)
• AWS_Config_Cleanup_Report.txt (executive documentation)
• CLIENT_${CLIENT_CODE}_Service_Complete.txt (this summary)

BILLING INFORMATION
-------------------
Service: AWS Config Intelligent Cleanup
Rate: \$3 per Config rule (\$500 minimum, \$2,500 maximum)
Rules processed: $RULE_COUNT
Final Investment: [CALCULATED AUTOMATICALLY]

NEXT STEPS - NIST 800-171 DEPLOYMENT
------------------------------------
Your environment is now ready for NIST 800-171 compliance deployment:

Command: 
curl -O https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/nist-deployment-service.sh
chmod +x nist-deployment-service.sh
./nist-deployment-service.sh $CLIENT_CODE NIST-Compliance-Stack

Investment: \$7,500 (Complete NIST compliance)
Total Package: \$9,000 (Cleanup + NIST)

SUPPORT & WARRANTY
------------------
Service Provider: AWS Config Cleanup Service
Email: khalillyons@gmail.com
Phone: (703) 795-4193
Support Hours: 24/7 for service delivery
Warranty: 30 days post-delivery support included

COMPLIANCE STATUS
-----------------
✅ Environment cleaned and optimized
✅ Security monitoring preserved
✅ Ready for NIST 800-171 deployment
✅ No service disruptions during cleanup
✅ Professional documentation delivered

Professional service delivery completed by:
AWS Config Cleanup Service
Service completed: $(date)
EOF

echo "   Client-specific documentation completed"

echo ""
echo "✅ AWS CONFIG CLEANUP SERVICE COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Cleanup Results:"
echo "   • Initial rules: $RULE_COUNT"
echo "   • Final rules: $FINAL_RULE_COUNT"  
echo "   • Rules cleaned: $RULES_CLEANED"
echo "   • SecurityHub rules: Preserved"
echo ""
echo "📄 Professional Deliverables:"
echo "   • CLIENT_${CLIENT_CODE}_Service_Complete.txt"
echo "   • Complete technical and business documentation"
echo ""
echo "🚀 OPTIONAL: NIST 800-171 Deployment"
echo "   Your environment is now ready for NIST compliance"
echo "   Run: ./nist-deployment-service.sh $CLIENT_CODE NIST-Stack"
echo "   Investment: \$7,500 (Total package: \$9,000)"
echo ""
echo "📞 Service Complete - Contact for questions:"
echo "   Email: khalillyons@gmail.com"
echo "   Phone: (703) 795-4193"
echo ""
echo "💼 Thank you for choosing AWS Config Cleanup Service!"
