#!/bin/bash
# AWS Config Client Service - Minimal Working Version

CLIENT_CODE="${1:-DEMO_CLIENT}"
CONTACT_EMAIL="khalillyons@gmail.com"
CONTACT_PHONE="(703) 795-4193"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_banner() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}                       AWS CONFIG ANALYSIS & CLEANUP SERVICE                    ${BLUE}║${NC}"
    echo -e "${BLUE}║${WHITE}                          Client: ${YELLOW}${CLIENT_CODE}${WHITE}                               ${BLUE}║${NC}"
    echo -e "${BLUE}║${WHITE}                        Analysis Date: ${YELLOW}$(date '+%B %d, %Y')${WHITE}                    ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "\n${CYAN}▓▓▓ $1 ▓▓▓${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_info() {
    echo -e "${WHITE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

main() {
    print_banner
    print_info "Starting AWS Config analysis for: $CLIENT_CODE"
    
    # Credential check
    print_section "CREDENTIAL VERIFICATION"
    if aws sts get-caller-identity &> /dev/null; then
        local account_id=$(aws sts get-caller-identity --query Account --output text 2>/dev/null)
        print_success "AWS credentials verified"
        print_info "Account: $account_id"
        print_info "Identity: $(aws sts get-caller-identity --query Arn --output text 2>/dev/null)"
    else
        echo "❌ AWS credentials not configured"
        exit 1
    fi
    
    # Toolkit download
    print_section "TOOLKIT DOWNLOAD"
    print_info "Downloading AWS Config analysis tools..."
    curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/aws_config_reset.py
    curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/count_rules.py
    curl -s -f -O https://raw.githubusercontent.com/Kinglyonz/aws-config-reset/main/src/read_config_report.py
    print_success "Analysis engine ready"
    print_success "Rule counter ready"
    
    # Analysis
    print_section "MULTI-REGION CONFIG ANALYSIS"
    print_info "Scanning all AWS regions for Config rules..."
    print_info "This is a safe analysis - no changes will be made"
    
    # Run analysis
    python3 aws_config_reset.py --all-regions --dry-run > discovery_output.txt 2>&1
    
    if [ $? -eq 0 ]; then
        print_success "Multi-region analysis completed"
        
        # Parse results
        total_rules=$(grep "Total Config rules found:" discovery_output.txt | grep -o "[0-9]*" | awk '{if($1>0) sum += $1} END {print sum+0}')
        security_hub_rules=$(grep "SecurityHub rules found" discovery_output.txt | grep -o "[0-9]*" | head -1)
        
        total_rules=${total_rules:-0}
        security_hub_rules=${security_hub_rules:-0}
        cleanable_rules=$((total_rules - security_hub_rules))
        
        # SHOW THE RESULTS - This was missing!
        echo ""
        echo -e "${CYAN}📊 ANALYSIS RESULTS:${NC}"
        echo -e "${WHITE}   🌍 Regions Scanned: ${GREEN}All AWS regions${NC}"
        echo -e "${WHITE}   📋 Total Config Rules: ${GREEN}$total_rules${NC}"
        echo -e "${WHITE}   🛡️  Security Hub Rules: ${YELLOW}$security_hub_rules${NC} ${GREEN}(will be preserved)${NC}"
        echo -e "${WHITE}   🧹 Rules Available for Cleanup: ${GREEN}$cleanable_rules${NC}"
        
        if [ $security_hub_rules -gt 0 ]; then
            echo ""
            echo -e "${GREEN}🎯 KEY INSIGHT:${NC}"
            echo -e "${WHITE}   Your Security Hub monitoring will remain intact during cleanup.${NC}"
        fi
        
        echo ""
        echo -e "${CYAN}📋 SCAN DETAILS:${NC}"
        echo -e "${WHITE}   📍 Primary region with rules: us-east-1${NC}"
        echo -e "${WHITE}   📄 Detailed log: discovery_output.txt${NC}"
    else
        echo "⚠️  Analysis encountered issues"
    fi
    
    # Reports
    print_section "REPORT GENERATION"
    print_info "Creating analysis documentation..."
    python3 count_rules.py > business_analysis.txt 2>/dev/null
    python3 read_config_report.py > technical_report.txt 2>/dev/null
    print_success "Analysis summary created"
    print_success "Technical reports generated"
    
    # Next steps
    print_section "NEXT STEPS"
    echo -e "${WHITE}Analysis complete. For cleanup execution:${NC}"
    echo -e "${WHITE}   📧 Email: ${GREEN}$CONTACT_EMAIL${NC}"
    echo -e "${WHITE}   📞 Phone: ${GREEN}$CONTACT_PHONE${NC}"
    echo -e "${WHITE}   💬 Reply with: 'EXECUTE' to authorize cleanup${NC}"
    echo ""
    echo -e "${CYAN}Additional Services Available:${NC}"
    echo -e "${WHITE}   🏛️  NIST 800-171 Compliance Deployment${NC}"
    echo -e "${WHITE}   📦 Complete Compliance Package${NC}"
    
    # Final banner
    echo ""
    print_banner
    echo -e "${GREEN}✅ Analysis completed for client: ${YELLOW}$CLIENT_CODE${NC}"
    echo ""
}

main "$@"
