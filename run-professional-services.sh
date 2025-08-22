#!/bin/bash
# AWS Config Professional Services Portal - Auto-Execute Edition
# Usage: curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/run-professional-services.sh | bash -s CLIENT_CODE

# Professional color scheme
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# Service configuration
CLIENT_CODE="${1:-DEMO_$(date +%Y%m%d)}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

# Service pricing
INTELLIGENT_CLEANUP_COST=1500
NIST_DEPLOYMENT_COST=7500
COMPLETE_PACKAGE_COST=9000

print_portal_banner() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                    🏢 AWS CONFIG PROFESSIONAL SERVICES PORTAL                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                          Client: ${YELLOW}${CLIENT_CODE}${WHITE}                               ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                        Session: ${YELLOW}$(date '+%B %d, %Y at %I:%M %p')${WHITE}                ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "\n${BLUE}▓▓▓ $1 ▓▓▓${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

display_service_overview() {
    print_section "PROFESSIONAL SERVICES OVERVIEW"
    
    echo -e "${WHITE}🎯 ${BOLD}AUTO-EXECUTING: Intelligent Config Cleanup${NC} ${CYAN}(\$$(printf "%'d" $INTELLIGENT_CLEANUP_COST))${NC}"
    echo -e "${WHITE}   🛡️  Preserves Security Hub rules for continued monitoring${NC}"
    echo -e "${WHITE}   ⚡ 15-minute automated cleanup with professional documentation${NC}"
    echo -e "${WHITE}   🌍 Multi-region scanning and analysis${NC}"
    echo ""
    echo -e "${CYAN}💼 ADDITIONAL SERVICES AVAILABLE:${NC}"
    echo -e "${WHITE}   🏛️  NIST 800-171 Deployment: ${GREEN}\$$(printf "%'d" $NIST_DEPLOYMENT_COST)${NC}"
    echo -e "${WHITE}   🎁 Complete Package (Both): ${GREEN}\$$(printf "%'d" $COMPLETE_PACKAGE_COST)${NC} ${YELLOW}(Save \$1,000!)${NC}"
    echo ""
    echo -e "${PURPLE}📞 CONTACT FOR ADDITIONAL SERVICES:${NC}"
    echo -e "${WHITE}   📧 Email: ${GREEN}$CONTACT_EMAIL${NC}"
    echo -e "${WHITE}   📞 Phone: ${GREEN}$CONTACT_PHONE${NC}"
    echo ""
}

execute_intelligent_cleanup() {
    print_section "EXECUTING INTELLIGENT CONFIG CLEANUP"
    
    print_info "🚀 Automatically executing our most popular service for client: $CLIENT_CODE"
    print_info "🛡️  This service preserves Security Hub rules while cleaning unnecessary Config rules"
    
    echo ""
    echo -e "${CYAN}🎯 SERVICE DELIVERY IN PROGRESS...${NC}"
    echo ""
    
    # Execute the enhanced client service script with proper parameter passing
    if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"; then
        display_success_summary
    else
        display_error_summary
    fi
}

display_success_summary() {
    print_section "✅ SERVICE DELIVERY COMPLETED"
    
    echo -e "${GREEN}🎉 Intelligent Config Cleanup completed successfully for client: ${YELLOW}$CLIENT_CODE${NC}"
    echo ""
    echo -e "${WHITE}✅ What was delivered:${NC}"
    echo -e "${WHITE}   🔍 Multi-region AWS Config analysis${NC}"
    echo -e "${WHITE}   🛡️  Security Hub rule preservation${NC}"
    echo -e "${WHITE}   💰 Business value calculation${NC}"
    echo -e "${WHITE}   📊 Professional documentation${NC}"
    echo -e "${WHITE}   🎯 Zero-risk environment assessment${NC}"
    echo ""
    echo -e "${PURPLE}🚀 READY FOR NEXT STEPS:${NC}"
    echo -e "${WHITE}   For actual cleanup execution, contact us with 'EXECUTE' authorization${NC}"
    echo -e "${WHITE}   For NIST 800-171 deployment, request compliance package${NC}"
    echo -e "${WHITE}   For complete transformation, select our Complete Package${NC}"
    echo ""
    display_contact_and_upsell()
}

display_error_summary() {
    print_section "⚠️  SERVICE DELIVERY STATUS"
    
    print_warning "Service execution encountered an issue"
    print_info "This may be due to AWS credential configuration or permissions"
    echo ""
    echo -e "${WHITE}✅ What was still demonstrated:${NC}"
    echo -e "${WHITE}   🏢 Professional service presentation${NC}"
    echo -e "${WHITE}   🛡️  Security Hub preservation approach${NC}"
    echo -e "${WHITE}   💰 Business value methodology${NC}"
    echo -e "${WHITE}   📞 Direct access to professional support${NC}"
    echo ""
    display_contact_and_upsell()
}

display_contact_and_upsell() {
    print_section "💼 PROFESSIONAL SERVICES & CONTACT"
    
    echo -e "${CYAN}📞 IMMEDIATE SUPPORT & SERVICE UPGRADE:${NC}"
    echo -e "${WHITE}   📧 Email: ${GREEN}$CONTACT_EMAIL${NC}"
    echo -e "${WHITE}   📞 Phone: ${GREEN}$CONTACT_PHONE${NC}"
    echo -e "${WHITE}   ⚡ Response Time: ${GREEN}< 4 hours${NC}"
    echo ""
    echo -e "${YELLOW}🎁 UPGRADE TO COMPLETE PACKAGE:${NC}"
    echo -e "${WHITE}   💎 Intelligent Cleanup + NIST 800-171 Deployment${NC}"
    echo -e "${WHITE}   💰 Investment: ${GREEN}\$$(printf "%'d" $COMPLETE_PACKAGE_COST)${NC} ${YELLOW}(Save \$1,000!)${NC}"
    echo -e "${WHITE}   ⏱️  Duration: ${GREEN}45 minutes total${NC}"
    echo -e "${WHITE}   🏆 Complete compliance transformation${NC}"
    echo ""
    echo -e "${CYAN}🎯 WHY CHOOSE OUR PROFESSIONAL SERVICE:${NC}"
    echo -e "${WHITE}   ✅ ${GREEN}15 minutes${NC} vs ${RED}6-12 weeks${NC} (traditional consultants)${NC}"
    echo -e "${WHITE}   ✅ ${GREEN}\$1,500-\$9,000${NC} vs ${RED}\$50,000+${NC} (enterprise consultants)${NC}"
    echo -e "${WHITE}   ✅ ${GREEN}Security Hub preservation${NC} vs ${RED}broken monitoring${NC} (basic scripts)${NC}"
    echo -e "${WHITE}   ✅ ${GREEN}Professional documentation${NC} vs ${RED}no audit trail${NC} (DIY cleanup)${NC}"
    echo ""
    echo -e "${PURPLE}📋 SERVICE CODES FOR ADDITIONAL SERVICES:${NC}"
    echo -e "${WHITE}   To request NIST deployment: Contact us with client code ${YELLOW}$CLIENT_CODE${NC}"
    echo -e "${WHITE}   To upgrade to complete package: Reference session ${YELLOW}$TIMESTAMP${NC}"
    echo -e "${WHITE}   For custom enterprise needs: Mention this demo experience${NC}"
}

main() {
    print_portal_banner
    
    print_info "Welcome to AWS Config Professional Services - Auto-Execution Mode"
    print_info "Demonstrating our most popular service with immediate value delivery"
    
    display_service_overview
    
    # Auto-execute the intelligent cleanup service
    execute_intelligent_cleanup
    
    echo ""
    print_portal_banner
    echo -e "${GREEN}🎯 Professional service demonstration completed for client: ${YELLOW}$CLIENT_CODE${NC}"
    echo -e "${WHITE}Contact ${GREEN}$CONTACT_EMAIL${WHITE} or ${GREEN}$CONTACT_PHONE${WHITE} for service execution authorization.${NC}"
    echo ""
}

# Execute main function
main "$@"
