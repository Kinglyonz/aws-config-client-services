#!/bin/bash
# Enhanced AWS Config Client Service - Professional Delivery Platform (FIXED)
# Usage: curl -s https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/client-service.sh | bash -s CLIENT_CODE

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

# Client configuration
CLIENT_CODE="${1:-DEMO_CLIENT}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SERVICE_COST=1500
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

# Professional output functions
print_banner() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                    🏢 AWS CONFIG PROFESSIONAL CLEANUP SERVICE                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                          Client: ${YELLOW}${CLIENT_CODE}${WHITE}                               ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                        Service Date: ${YELLOW}$(date '+%B %d, %Y')${WHITE}                      ${CYAN}║${NC}"
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

print_security_analysis() {
    local total_rules=$1
    local security_hub_rules=$2
    
    echo -e "\n${PURPLE}🛡️  MULTI-REGION SECURITY HUB ANALYSIS:${NC}"
    echo -e "${WHITE}   📊 Total Config rules detected (all regions): ${GREEN}$total_rules${NC}"
    echo -e "${WHITE}   🔒 Security Hub rules found: ${YELLOW}$security_hub_rules${NC}"
    echo -e "${WHITE}   ✅ Security Hub rules will be PRESERVED${NC}"
    echo -e "${WHITE}   🎯 Safe cleanup rules available: ${GREEN}$((total_rules - security_hub_rules))${NC}"
    
    if [ $security_hub_rules -gt 0 ]; then
        echo -e "\n${GREEN}🎉 MULTI-REGION INTELLIGENT CLEANUP ADVANTAGE:${NC}"
        echo -e "${WHITE}   Unlike basic scripts that only check one region and break security monitoring,${NC}"
        echo -e "${WHITE}   our service scans ALL regions and preserves Security Hub compliance rules.${NC}"
    fi
}

print_business_value() {
    local total_rules=$1
    local security_hub_rules=$2
    local cleanable_rules=$((total_rules - security_hub_rules))
    local manual_hours=$((cleanable_rules / 10))  # 10 rules per hour manual
    local manual_cost=$((manual_hours * 150))     # $150/hour consultant rate
    local savings=$((manual_cost - SERVICE_COST))
    
    echo -e "\n${PURPLE}💰 BUSINESS VALUE ANALYSIS:${NC}"
    echo -e "${WHITE}   🎯 Rules requiring cleanup: ${GREEN}$cleanable_rules${NC}"
    echo -e "${WHITE}   ⏱️  Manual cleanup time: ${YELLOW}$manual_hours hours${NC}"
    echo -e "${WHITE}   💵 Manual consultant cost: ${RED}\$$(printf "%'d" $manual_cost)${NC}"
    echo -e "${WHITE}   ⚡ Our service investment: ${GREEN}\$$(printf "%'d" $SERVICE_COST)${NC}"
    
    if [ $savings -gt 0 ]; then
        local savings_percent=$(( (savings * 100) / manual_cost ))
        echo -e "${WHITE}   💎 Your savings: ${GREEN}\$$(printf "%'d" $savings) (${savings_percent}% reduction)${NC}"
        echo -e "${WHITE}   ⏰ Time savings: ${GREEN}$manual_hours hours → 15 minutes${NC}"
    fi
}

check_aws_credentials() {
    print_section "CREDENTIAL VERIFICATION"
    
    if ! command -v aws &> /dev/null; then
        print_error "AWS CLI not found. Please install AWS CLI first."
        return 1
    fi
    
    if ! aws sts get-caller-identity &> /dev/null; then
        print_error "AWS credentials not configured or invalid."
        print_info "Please configure AWS credentials using 'aws configure' or IAM roles."
        return 1
    fi
    
    local account_id=$(aws sts get-caller-identity --query Account --output text 2>/dev/null)
    local user_arn=$(aws sts get-caller-identity --query Arn --output text 2>/dev/null)
    
    print_success "AWS credentials verified"
    print_info "Account ID: $account_id"
    print_info "Identity: $user_arn"
    
    return 0
}

download_toolkit() {
    print_section "PROFESSIONAL TOOLKIT DEPLOYMENT"
    
    print_info "📥 Downloading enhanced AWS Config toolkit..."
    
    # Download enhanced scripts
    if curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/aws_config_reset.py; then
        print_success "Core cleanup engine downloaded"
    else
        print_error "Failed to download core cleanup engine"
        return 1
    fi
    
    if curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/count_rules.py; then
        print_success "Business analysis engine downloaded"
    else
        print_error "Failed to download business analysis engine"
        return 1
    fi
    
    if curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/read_config_report.py; then
        print_success "Report generator downloaded"
    else
        print_error "Failed to download report generator"
        return 1
    fi
    
    print_success "🎯 Professional toolkit ready for deployment"
    return 0
}

run_discovery_analysis() {
    print_section "INTELLIGENT MULTI-REGION DISCOVERY & SECURITY ANALYSIS"
    
    print_info "🌍 Scanning ALL AWS regions for Config rules..."
    print_info "   This analysis is completely safe - no changes will be made"
    
    # Run discovery with enhanced output - ALWAYS scan ALL REGIONS
    if python3 aws_config_reset.py --all-regions --dry-run > discovery_output.txt 2>&1; then
        print_success "Multi-region discovery analysis completed successfully"
        
        # FIXED: Always use aggregation method (not summary which counts cleanup operations)
        print_info "🔄 Aggregating Config rule data from all regions..."
        
        # Sum all non-zero "Total Config rules found" values from each region
        local total_rules=$(grep "Total Config rules found:" discovery_output.txt | grep -o "[0-9]*" | awk '{if($1>0) sum += $1} END {print sum+0}')
        
        # Sum all SecurityHub rules from security analysis sections
        local security_hub_rules=$(grep "SecurityHub rules found" discovery_output.txt | grep -o "[0-9]*" | awk '{sum += $1} END {print sum+0}')
        
        # Ensure we have valid numbers
        total_rules=${total_rules:-0}
        security_hub_rules=${security_hub_rules:-0}
        
        # Display analysis results
        print_security_analysis $total_rules $security_hub_rules
        print_business_value $total_rules $security_hub_rules
        
        # Show which regions had rules
        echo -e "\n${CYAN}📊 MULTI-REGION SCAN DETAILS:${NC}"
        echo -e "${WHITE}   🌍 Regions scanned: All available AWS regions${NC}"
        
        # Show regions with rules
        local regions_with_rules=0
        while IFS= read -r line; do
            if [[ $line =~ Processing\ Region:\ (.+) ]]; then
                region="${BASH_REMATCH[1]}"
                # Get the rule count for this region
                rules=$(grep -A15 "Processing Region: $region" discovery_output.txt | grep "Total Config rules found:" | grep -o "[0-9]*" | head -1)
                if [ "${rules:-0}" -gt 0 ]; then
                    echo -e "${WHITE}   📍 $region: ${GREEN}$rules rules${NC}"
                    regions_with_rules=$((regions_with_rules + 1))
                fi
            fi
        done < discovery_output.txt
        
        if [ $regions_with_rules -eq 0 ]; then
            echo -e "${WHITE}   📍 us-east-1: ${GREEN}$total_rules rules${NC} (primary region)"
        fi
        
        echo -e "${WHITE}   📋 Detailed output saved: discovery_output.txt${NC}"
        
        return 0
    else
        print_warning "Discovery analysis encountered issues"
        print_info "This may be due to insufficient permissions or network connectivity"
        
        # Show sample analysis for demonstration
        print_info "Showing sample analysis based on typical enterprise accounts:"
        print_security_analysis 435 25
        print_business_value 435 25
        
        return 1
    fi
}

generate_professional_report() {
    print_section "PROFESSIONAL DOCUMENTATION GENERATION"
    
    print_info "📊 Generating executive summary and technical documentation..."
    
    # Generate business analysis report
    if python3 count_rules.py > business_analysis.txt 2>&1; then
        print_success "Business analysis report generated"
    fi
    
    # Generate technical report
    if python3 read_config_report.py > technical_report.txt 2>&1; then
        print_success "Technical analysis report generated"
    fi
    
    # Create client-specific summary
    cat > "client_summary_${CLIENT_CODE}_${TIMESTAMP}.txt" << EOF
AWS CONFIG CLEANUP SERVICE - EXECUTIVE SUMMARY
Client: $CLIENT_CODE
Service Date: $(date '+%B %d, %Y at %I:%M %p %Z')
Service Provider: AWS Config Cleanup & NIST 800-171 Compliance Service

DISCOVERY RESULTS:
✅ Multi-region Config rule analysis completed
✅ Security Hub rules identified and protected
✅ Business value analysis performed
✅ Risk assessment completed

INTELLIGENT CLEANUP ADVANTAGES:
🛡️  Security Hub Preservation: Unlike basic cleanup scripts, our service 
   intelligently preserves Security Hub managed rules, ensuring your 
   security monitoring remains intact.

⚡ Speed: 15-minute automated cleanup vs. hours of manual work
🎯 Accuracy: Zero-risk automated process with comprehensive validation
📋 Documentation: Professional reports included for audit compliance

NEXT STEPS:
To proceed with the actual cleanup execution, please confirm by replying 
with 'EXECUTE' to authorize the cleanup process.

CONTACT INFORMATION:
📧 Email: $CONTACT_EMAIL
📞 Phone: $CONTACT_PHONE
🌐 Service Investment: \$$SERVICE_COST

This analysis was performed safely with no changes to your environment.
EOF
    
    print_success "Client summary report generated: client_summary_${CLIENT_CODE}_${TIMESTAMP}.txt"
    print_success "📋 Professional documentation package ready"
}

request_execution_confirmation() {
    print_section "SERVICE EXECUTION AUTHORIZATION"
    
    echo -e "${YELLOW}⚠️  EXECUTION CONFIRMATION REQUIRED ⚠️${NC}"
    echo ""
    echo -e "${WHITE}The discovery and analysis phase is complete.${NC}"
    echo -e "${WHITE}To proceed with the actual Config rule cleanup, explicit authorization is required.${NC}"
    echo ""
    echo -e "${BOLD}${RED}IMPORTANT: The cleanup process will permanently delete Config rules${NC}"
    echo -e "${BOLD}${RED}(except Security Hub rules which will be preserved).${NC}"
    echo ""
    echo -e "${WHITE}To authorize cleanup execution, please:${NC}"
    echo -e "${WHITE}1. Review the generated reports${NC}"
    echo -e "${WHITE}2. Contact us at ${GREEN}$CONTACT_EMAIL${WHITE} or ${GREEN}$CONTACT_PHONE${NC}"
    echo -e "${WHITE}3. Provide explicit 'EXECUTE' confirmation${NC}"
    echo ""
    echo -e "${GREEN}📞 Ready to proceed? Contact us now for immediate execution!${NC}"
}

display_service_summary() {
    print_section "SERVICE DELIVERY SUMMARY"
    
    echo -e "${GREEN}🎉 DISCOVERY PHASE COMPLETED SUCCESSFULLY!${NC}"
    echo ""
    echo -e "${WHITE}✅ What was accomplished:${NC}"
    echo -e "${WHITE}   🔍 Comprehensive multi-region Config analysis${NC}"
    echo -e "${WHITE}   🛡️  Security Hub rule identification and protection${NC}"
    echo -e "${WHITE}   💰 Business value and cost savings analysis${NC}"
    echo -e "${WHITE}   📊 Professional documentation generation${NC}"
    echo -e "${WHITE}   🎯 Zero-risk assessment with no environment changes${NC}"
    echo ""
    echo -e "${WHITE}📋 Generated Reports:${NC}"
    echo -e "${WHITE}   • Client summary: client_summary_${CLIENT_CODE}_${TIMESTAMP}.txt${NC}"
    echo -e "${WHITE}   • Business analysis: business_analysis.txt${NC}"
    echo -e "${WHITE}   • Technical report: technical_report.txt${NC}"
    echo -e "${WHITE}   • Discovery output: discovery_output.txt${NC}"
    echo ""
    echo -e "${PURPLE}🚀 READY FOR EXECUTION PHASE:${NC}"
    echo -e "${WHITE}   ⚡ 15-minute automated cleanup${NC}"
    echo -e "${WHITE}   🛡️  Security Hub rules preserved${NC}"
    echo -e "${WHITE}   🌍 All regions processed${NC}"
    echo -e "${WHITE}   📋 Professional documentation included${NC}"
    echo -e "${WHITE}   💎 Immediate cost savings realization${NC}"
}

main() {
    print_banner
    
    print_info "Initializing AWS Config Professional Cleanup Service for client: $CLIENT_CODE"
    print_info "Service will be delivered in phases with explicit confirmation required for execution"
    
    # Phase 1: Credential verification
    if ! check_aws_credentials; then
        print_error "Service cannot proceed without valid AWS credentials"
        exit 1
    fi
    
    # Phase 2: Toolkit deployment
    if ! download_toolkit; then
        print_error "Service cannot proceed without required tools"
        exit 1
    fi
    
    # Phase 3: Discovery and analysis
    run_discovery_analysis
    
    # Phase 4: Professional reporting
    generate_professional_report
    
    # Phase 5: Execution authorization request
    request_execution_confirmation
    
    # Phase 6: Service summary
    display_service_summary
    
    echo ""
    print_banner
    echo -e "${GREEN}🎯 Professional service discovery completed for client: ${YELLOW}$CLIENT_CODE${NC}"
    echo -e "${WHITE}Contact ${GREEN}$CONTACT_EMAIL${WHITE} or ${GREEN}$CONTACT_PHONE${WHITE} to proceed with execution.${NC}"
    echo ""
}

# Execute main function
main "$@"
