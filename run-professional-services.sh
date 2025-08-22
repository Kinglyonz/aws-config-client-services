#!/bin/bash
CLIENT_CODE="${1:-DEMO_CLIENT}"

echo "🚀 AWS Config Professional Service Portal"
echo "Client: $CLIENT_CODE"
echo ""

# Just run the analysis ONCE
curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"

echo ""
echo "📞 Contact: khalillyons@gmail.com | (703) 795-4193"
