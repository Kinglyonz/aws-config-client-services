#!/bin/bash
# AWS Config Professional Services Portal - No Loop Version

CLIENT_CODE="${1:-DEMO_CLIENT}"
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║        AWS CONFIG PROFESSIONAL SERVICES PORTAL       ║"
echo "║                  Client: $CLIENT_CODE                 ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Executing AWS Config Analysis..."
echo ""

# Execute the client service ONCE with proper error handling
curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"

# That's it - no loops, no multiple calls
echo ""
echo "📞 CONTACT FOR SERVICES:"
echo "   Email: $CONTACT_EMAIL"
echo "   Phone: $CONTACT_PHONE"
