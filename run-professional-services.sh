#!/bin/bash
# AWS Config Professional Services Portal - Emergency Working Version

CLIENT_CODE="${1:-DEMO_CLIENT}"
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

clear
echo "╔═══════════════════════════════════════════════════════╗"
echo "║        AWS CONFIG PROFESSIONAL SERVICES PORTAL       ║"
echo "║                  Client: $CLIENT_CODE                 ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Auto-executing Intelligent Cleanup Analysis..."
echo ""

# Execute the client service with proper error handling
if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"; then
    echo ""
    echo "✅ Analysis completed successfully!"
    echo ""
    echo "📞 NEXT STEPS:"
    echo "   Email: $CONTACT_EMAIL"
    echo "   Phone: $CONTACT_PHONE"
    echo "   For execution authorization: Reply with 'EXECUTE'"
else
    echo ""
    echo "⚠️  Analysis encountered issues"
    echo "📞 Contact: $CONTACT_EMAIL for support"
fi

echo ""
echo "💼 ADDITIONAL SERVICES AVAILABLE:"
echo "   🏛️  NIST 800-171 Deployment: \$7,500"  
echo "   🎁 Complete Package: \$9,000 (Save \$1,000!)"
echo ""
