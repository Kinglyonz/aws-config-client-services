#!/bin/bash
CLIENT_CODE="${1:-DEMO_CLIENT}"

echo "📊 AWS Config Analysis for: $CLIENT_CODE"
echo ""

# Download tools
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/aws_config_reset.py

# Run analysis
python3 aws_config_reset.py --all-regions --dry-run > discovery_output.txt 2>&1

# Parse and show results
total_rules=$(grep "Total Config rules found:" discovery_output.txt | grep -o "[0-9]*" | awk '{if($1>0) sum += $1} END {print sum+0}')
security_hub_rules=$(grep "SecurityHub rules found" discovery_output.txt | grep -o "[0-9]*" | head -1)

echo "✅ ANALYSIS RESULTS:"
echo "   Total Config Rules: ${total_rules:-0}"
echo "   Security Hub Rules: ${security_hub_rules:-0} (preserved)"
echo "   Cleanup Available: $((${total_rules:-0} - ${security_hub_rules:-0}))"
echo ""
echo "✅ Analysis complete"
