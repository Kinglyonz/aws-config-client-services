#!/bin/bash
# AWS Config Professional Services Portal - Master Client Interface (COMPLETE FIXED VERSION)
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
CLIENT_CODE="${1:-$(date +%Y%m%d)_CLIENT}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

# Service pricing
INTELLIGENT_CLEANUP_COST=1500
NIST_DEPLOYMENT_COST=7500
COMPLETE_PACKAGE_COST=9000
NUCLEAR_CLEANUP_COST=1500

# Professional output functions
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

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

display_service_menu() {
    print_section "PROFESSIONAL SERVICES MENU"
    
    echo -e "${WHITE}Please select the service you wish to engage:${NC}"
    echo ""
    echo -e "${GREEN}1.${NC} ${WHITE}Intelligent Config Cleanup${NC} ${CYAN}(\$$(printf "%'d" $INTELLIGENT_CLEANUP_COST))${NC}"
    echo -e "   ${CYAN}🛡️  Preserves Security Hub rules for continued monitoring${NC}"
    echo -e "   ${CYAN}⚡ 15-minute automated cleanup with professional documentation${NC}"
    echo -e "   ${CYAN}🎯 Recommended for most clients - safest option${NC}"
    echo ""
    echo -e "${GREEN}2.${NC} ${WHITE}NIST 800-171 Compliance Deployment${NC} ${CYAN}(\$$(printf "%'d" $NIST_DEPLOYMENT_COST))${NC}"
    echo -e "   ${CYAN}🏛️  Deploy 100+ NIST compliance Config rules via CloudFormation${NC}"
    echo -e "   ${CYAN}📋 Complete compliance documentation and monitoring setup${NC}"
    echo -e "   ${CYAN}⏱️  30-minute professional deployment with validation${NC}"
    echo ""
    echo -e "${GREEN}3.${NC} ${WHITE}Complete Compliance Package${NC} ${CYAN}(\$$(printf "%'d" $COMPLETE_PACKAGE_COST))${NC} ${YELLOW}(Save \$1,000!)${NC}"
    echo -e "   ${CYAN}🎁 Intelligent Cleanup + NIST Deployment combined${NC}"
    echo -e "   ${CYAN}🚀 End-to-end compliance transformation in 45 minutes${NC}"
    echo -e "   ${CYAN}💎 Best value for comprehensive compliance needs${NC}"
    echo ""
    echo -e "${RED}4.${NC} ${WHITE}Nuclear Cleanup with Backup${NC} ${CYAN}(\$$(printf "%'d" $NUCLEAR_CLEANUP_COST))${NC} ${RED}(ADVANCED)${NC}"
    echo -e "   ${RED}💥 Deletes ALL Config rules including Security Hub rules${NC}"
    echo -e "   ${RED}⚠️  Disables security monitoring - use with extreme caution${NC}"
    echo -e "   ${GREEN}📦 Includes comprehensive backup and restore capability${NC}"
    echo ""
    echo -e "${BLUE}5.${NC} ${WHITE}Service Information & Support${NC}"
    echo -e "   ${CYAN}📞 Contact information and service details${NC}"
    echo ""
    echo -e "${PURPLE}6.${NC} ${WHITE}Exit Portal${NC}"
    echo ""
}

display_service_info() {
    print_section "SERVICE INFORMATION & SUPPORT"
    
    echo -e "${WHITE}🏢 AWS Config Cleanup & NIST 800-171 Compliance Service${NC}"
    echo ""
    echo -e "${CYAN}📞 CONTACT INFORMATION:${NC}"
    echo -e "${WHITE}   📧 Email: ${GREEN}$CONTACT_EMAIL${NC}"
    echo -e "${WHITE}   📞 Phone: ${GREEN}$CONTACT_PHONE${NC}"
    echo -e "${WHITE}   🕒 Business Hours: 24/7 availability for service execution${NC}"
    echo -e "${WHITE}   ⚡ Response Time: Real-time during service delivery${NC}"
    echo ""
    echo -e "${CYAN}🎯 SERVICE ADVANTAGES:${NC}"
    echo -e "${WHITE}   ✅ Fastest deployment: 15-45 minutes vs 6-12 weeks${NC}"
    echo -e "${WHITE}   ✅ Most cost-effective: \$1,500-\$9,000 vs \$50,000+ consultants${NC}"
    echo -e "${WHITE}   ✅ Proven compliance: Based on official AWS Config rules${NC}"
    echo -e "${WHITE}   ✅ Professional documentation: Executive and audit-ready reports${NC}"
    echo -e "${WHITE}   ✅ Ongoing support: Monthly monitoring and reporting available${NC}"
    echo ""
    echo -e "${CYAN}🛡️  SECURITY HUB PRESERVATION:${NC}"
    echo -e "${WHITE}   Our Intelligent Cleanup preserves Security Hub rules, ensuring${NC}"
    echo -e "${WHITE}   your security monitoring remains intact during cleanup.${NC}"
    echo -e "${WHITE}   This is a key differentiator from basic cleanup scripts.${NC}"
    echo ""
    echo -e "${CYAN}📋 PROFESSIONAL DOCUMENTATION:${NC}"
    echo -e "${WHITE}   • Executive summary reports${NC}"
    echo -e "${WHITE}   • Technical implementation details${NC}"
    echo -e "${WHITE}   • Compliance audit documentation${NC}"
    echo -e "${WHITE}   • Business value and ROI analysis${NC}"
    echo ""
    
    read -p "Press Enter to return to main menu..."
}

execute_intelligent_cleanup() {
    print_section "INTELLIGENT CONFIG CLEANUP SERVICE"
    
    print_info "Initiating Intelligent Config Cleanup for client: $CLIENT_CODE"
    print_info "This service preserves Security Hub rules while cleaning up unnecessary Config rules"
    
    echo ""
    echo -e "${WHITE}Service Details:${NC}"
    echo -e "${WHITE}   💰 Investment: ${GREEN}\$$(printf "%'d" $INTELLIGENT_CLEANUP_COST)${NC}"
    echo -e "${WHITE}   ⏱️  Duration: ${GREEN}15 minutes${NC}"
    echo -e "${WHITE}   🛡️  Security Hub: ${GREEN}Preserved${NC}"
    echo -e "${WHITE}   📋 Documentation: ${GREEN}Included${NC}"
    echo ""
    
    read -p "Proceed with Intelligent Cleanup? (y/N): " confirm
    
    if [[ $confirm =~ ^[Yy]$ ]]; then
        print_success "Executing Intelligent Config Cleanup..."
        
        # FIXED: Download and execute the enhanced client service script with proper parameter passing
        if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"; then
            print_success "Intelligent Cleanup service completed successfully!"
        else
            print_error "Service execution encountered issues"
            print_info "Please contact support: $CONTACT_EMAIL"
        fi
    else
        print_info "Intelligent Cleanup cancelled"
    fi
}

execute_nist_deployment() {
    print_section "NIST 800-171 COMPLIANCE DEPLOYMENT"
    
    print_info "Initiating NIST 800-171 Compliance Deployment for client: $CLIENT_CODE"
    print_info "This service deploys 100+ compliance Config rules via CloudFormation"
    
    echo ""
    echo -e "${WHITE}Service Details:${NC}"
    echo -e "${WHITE}   💰 Investment: ${GREEN}\$$(printf "%'d" $NIST_DEPLOYMENT_COST)${NC}"
    echo -e "${WHITE}   ⏱️  Duration: ${GREEN}30 minutes${NC}"
    echo -e "${WHITE}   🏛️  Rules Deployed: ${GREEN}100+ NIST compliance rules${NC}"
    echo -e "${WHITE}   📋 Documentation: ${GREEN}Complete compliance package${NC}"
    echo ""
    
    read -p "Enter CloudFormation stack name (or press Enter for default): " stack_name
    stack_name=${stack_name:-"nist-800-171-compliance-${CLIENT_CODE}"}
    
    read -p "Proceed with NIST Deployment? (y/N): " confirm
    
    if [[ $confirm =~ ^[Yy]$ ]]; then
        print_success "Executing NIST 800-171 Deployment..."
        
        # FIXED: Download and execute the NIST deployment script with proper parameter passing
        if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/nist-deployment-service.sh | bash -s "$CLIENT_CODE" "$stack_name"; then
            print_success "NIST Deployment service completed successfully!"
        else
            print_error "Service execution encountered issues"
            print_info "Please contact support: $CONTACT_EMAIL"
        fi
    else
        print_info "NIST Deployment cancelled"
    fi
}

execute_complete_package() {
    print_section "COMPLETE COMPLIANCE PACKAGE"
    
    print_info "Initiating Complete Compliance Package for client: $CLIENT_CODE"
    print_info "This combines Intelligent Cleanup + NIST Deployment for maximum value"
    
    echo ""
    echo -e "${WHITE}Package Details:${NC}"
    echo -e "${WHITE}   💰 Investment: ${GREEN}\$$(printf "%'d" $COMPLETE_PACKAGE_COST)${NC} ${YELLOW}(Save \$1,000!)${NC}"
    echo -e "${WHITE}   ⏱️  Duration: ${GREEN}45 minutes total${NC}"
    echo -e "${WHITE}   🧹 Phase 1: ${GREEN}Intelligent Cleanup (15 min)${NC}"
    echo -e "${WHITE}   🏛️  Phase 2: ${GREEN}NIST Deployment (30 min)${NC}"
    echo -e "${WHITE}   📋 Documentation: ${GREEN}Complete compliance transformation${NC}"
    echo ""
    
    read -p "Enter CloudFormation stack name (or press Enter for default): " stack_name
    stack_name=${stack_name:-"nist-800-171-compliance-${CLIENT_CODE}"}
    
    read -p "Proceed with Complete Package? (y/N): " confirm
    
    if [[ $confirm =~ ^[Yy]$ ]]; then
        print_success "Executing Complete Compliance Package..."
        
        print_info "Phase 1: Intelligent Config Cleanup"
        # FIXED: Use proper parameter passing with -s flag
        if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s "$CLIENT_CODE"; then
            print_success "Phase 1 completed successfully!"
            
            print_info "Phase 2: NIST 800-171 Deployment"
            # FIXED: Use proper parameter passing with -s flag
            if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/nist-deployment-service.sh | bash -s "$CLIENT_CODE" "$stack_name"; then
                print_success "Complete Package service completed successfully!"
                print_success "🎉 Your AWS environment is now fully compliant and optimized!"
            else
                print_error "Phase 2 encountered issues"
                print_info "Phase 1 was successful. Contact support for Phase 2 completion: $CONTACT_EMAIL"
            fi
        else
            print_error "Phase 1 encountered issues"
            print_info "Please contact support: $CONTACT_EMAIL"
        fi
    else
        print_info "Complete Package cancelled"
    fi
}

execute_nuclear_cleanup() {
    print_section "NUCLEAR CLEANUP WITH BACKUP (ADVANCED)"
    
    print_warning "This is the DESTRUCTIVE option - use with extreme caution"
    print_warning "This will DELETE ALL Config rules including Security Hub rules"
    
    echo ""
    echo -e "${RED}${BOLD}⚠️  CRITICAL WARNINGS:${NC}"
    echo -e "${RED}   💥 Deletes ALL AWS Config rules${NC}"
    echo -e "${RED}   💥 Disables Security Hub monitoring${NC}"
    echo -e "${RED}   💥 Removes all compliance monitoring${NC}"
    echo ""
    echo -e "${GREEN}✅ Safety Measures:${NC}"
    echo -e "${GREEN}   📦 Complete backup created before deletion${NC}"
    echo -e "${GREEN}   🔧 Restore capability provided${NC}"
    echo -e "${GREEN}   📞 Professional support included${NC}"
    echo ""
    echo -e "${WHITE}Service Details:${NC}"
    echo -e "${WHITE}   💰 Investment: ${GREEN}\$$(printf "%'d" $NUCLEAR_CLEANUP_COST)${NC}"
    echo -e "${WHITE}   ⏱️  Duration: ${GREEN}20 minutes${NC}"
    echo -e "${WHITE}   💥 Scope: ${RED}COMPLETE DESTRUCTION${NC}"
    echo -e "${WHITE}   📦 Backup: ${GREEN}Comprehensive${NC}"
    echo ""
    
    read -p "Do you understand this will DELETE Security Hub rules? (type 'YES' to confirm): " confirm1
    
    if [ "$confirm1" = "YES" ]; then
        read -p "Are you absolutely sure you want NUCLEAR cleanup? (type 'NUCLEAR' to confirm): " confirm2
        
        if [ "$confirm2" = "NUCLEAR" ]; then
            print_warning "Executing Nuclear Cleanup with Backup..."
            
            # FIXED: Download and execute the nuclear cleanup script with proper parameter passing
            if curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/nuclear-cleanup-service.sh | bash -s "$CLIENT_CODE"; then
                print_success "Nuclear Cleanup service completed!"
                print_warning "🛡️  Security monitoring is now OFFLINE"
                print_info "📦 Backup available for restore if needed"
            else
                print_error "Service execution encountered issues"
                print_info "Please contact support: $CONTACT_EMAIL"
            fi
        else
            print_info "Nuclear Cleanup cancelled - wise choice!"
            print_info "Consider our Intelligent Cleanup instead for safer operation"
        fi
    else
        print_info "Nuclear Cleanup cancelled"
    fi
}

main() {
    while true; do
        print_portal_banner
        
        print_info "Welcome to the AWS Config Professional Services Portal"
        print_info "All services include professional documentation and support"
        
        display_service_menu
        
        read -p "Enter your choice (1-6): " choice
        
        case $choice in
            1)
                execute_intelligent_cleanup
                ;;
            2)
                execute_nist_deployment
                ;;
            3)
                execute_complete_package
                ;;
            4)
                execute_nuclear_cleanup
                ;;
            5)
                display_service_info
                ;;
            6)
                print_success "Thank you for using AWS Config Professional Services"
                print_info "Contact us anytime: $CONTACT_EMAIL or $CONTACT_PHONE"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please select 1-6."
                read -p "Press Enter to continue..."
                ;;
        esac
        
        echo ""
        read -p "Press Enter to return to main menu..."
    done
}

# Execute main function
main "$@"
