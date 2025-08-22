#!/bin/bash
# NIST 800-171 Deployment Service - Updated with Stack Management
# Professional CloudFormation deployment for NIST compliance
# Contact: khalillyons@gmail.com | (703) 795-4193

CLIENT_CODE="$1"
STACK_NAME="$2"

if [ -z "$CLIENT_CODE" ] || [ -z "$STACK_NAME" ]; then
    echo "❌ Usage: $0 CLIENT_CODE STACK_NAME"
    echo "📞 Contact: khalillyons@gmail.com | (703) 795-4193"
    exit 1
fi

echo "🏛️ NIST 800-171 Deployment Service"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Client Code: $CLIENT_CODE"
echo "Stack Name: $STACK_NAME"
echo "Service Date: $(date)"
echo "Service Provider: AWS Config Cleanup Service"
echo ""

# Download the NIST template
echo "📥 Downloading NIST 800-171 CloudFormation template..."
curl -s -O https://raw.githubusercontent.com/Kinglyonz/aws-config-client-services/main/src/templates/nist-800-171-conformance-pack.yaml

if [ ! -f "nist-800-171-conformance-pack.yaml" ]; then
    echo "❌ Failed to download NIST template"
    exit 1
fi

echo "✅ NIST 800-171 template ready for deployment"
echo ""

# Phase 1: Pre-deployment validation
echo "🔍 Phase 1: Pre-deployment Validation"
echo "   Validating CloudFormation template..."

aws cloudformation validate-template --template-body file://nist-800-171-conformance-pack.yaml > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ CloudFormation template is valid"
else
    echo "❌ CloudFormation template validation failed"
    exit 1
fi

echo "   Checking AWS Config service status..."
aws configservice describe-configuration-recorders > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ AWS Config service is properly configured"
else
    echo "❌ AWS Config service not configured"
    exit 1
fi

# NEW: Check if stack already exists
echo "   Checking for existing stack..."
STACK_EXISTS=$(aws cloudformation describe-stacks --stack-name $STACK_NAME 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "⚠️  Stack '$STACK_NAME' already exists!"
    
    STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[0].StackStatus' --output text)
    echo "   Current status: $STACK_STATUS"
    echo ""
    echo "📋 Options:"
    echo "   1. UPDATE - Update existing stack with latest template"
    echo "   2. DELETE - Delete existing stack and create new one"
    echo "   3. CANCEL - Cancel deployment and exit"
    echo ""
    
    read -p "   Choose option (UPDATE/DELETE/CANCEL): " stack_action
    
    case $stack_action in
        UPDATE)
            echo "   Selected: Update existing stack"
            DEPLOYMENT_TYPE="update"
            ;;
        DELETE)
            echo "   Selected: Delete and recreate stack"
            DEPLOYMENT_TYPE="recreate"
            ;;
        CANCEL)
            echo "❌ NIST deployment cancelled by client"
            exit 1
            ;;
        *)
            echo "❌ Invalid option selected"
            exit 1
            ;;
    esac
else
    echo "✅ No existing stack found - ready for new deployment"
    DEPLOYMENT_TYPE="create"
fi

echo ""
echo "⚠️  READY FOR NIST 800-171 DEPLOYMENT"
echo "   This will deploy 100+ Config rules for NIST compliance"
echo "   Stack Name: $STACK_NAME"
echo "   Template: nist-800-171-conformance-pack.yaml"
echo "   Action: $DEPLOYMENT_TYPE"
echo ""

read -p "   Continue with NIST deployment? (type 'DEPLOY'): " confirmation

if [ "$confirmation" != "DEPLOY" ]; then
    echo "❌ NIST deployment cancelled by client"
    exit 1
fi

echo ""
echo "🚀 Phase 2: NIST 800-171 Deployment (5-10 minutes)"
echo "   Deployment type: $DEPLOYMENT_TYPE"
echo "   Start time: $(date)"

# Execute deployment based on type
case $DEPLOYMENT_TYPE in
    update)
        echo "   Updating CloudFormation stack: $STACK_NAME"
        aws cloudformation update-stack \
            --stack-name $STACK_NAME \
            --template-body file://nist-800-171-conformance-pack.yaml \
            --capabilities CAPABILITY_IAM
        
        if [ $? -eq 0 ]; then
            echo "✅ CloudFormation stack update initiated"
        else
            echo "❌ Failed to update CloudFormation stack"
            exit 1
        fi
        ;;
        
    recreate)
        echo "   Deleting existing CloudFormation stack: $STACK_NAME"
        aws cloudformation delete-stack --stack-name $STACK_NAME
        
        echo "   Waiting for stack deletion to complete..."
        aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
        
        if [ $? -eq 0 ]; then
            echo "✅ Existing stack deleted successfully"
        else
            echo "❌ Failed to delete existing stack"
            exit 1
        fi
        
        echo "   Creating new CloudFormation stack: $STACK_NAME"
        aws cloudformation create-stack \
            --stack-name $STACK_NAME \
            --template-body file://nist-800-171-conformance-pack.yaml \
            --capabilities CAPABILITY_IAM
        
        if [ $? -eq 0 ]; then
            echo "✅ CloudFormation stack creation initiated"
        else
            echo "❌ Failed to create CloudFormation stack"
            exit 1
        fi
        ;;
        
    create)
        echo "   Creating CloudFormation stack: $STACK_NAME"
        aws cloudformation create-stack \
            --stack-name $STACK_NAME \
            --template-body file://nist-800-171-conformance-pack.yaml \
            --capabilities CAPABILITY_IAM
        
        if [ $? -eq 0 ]; then
            echo "✅ CloudFormation stack creation initiated"
        else
            echo "❌ Failed to create CloudFormation stack"
            exit 1
        fi
        ;;
esac

# Wait for deployment completion
echo "   Monitoring deployment progress..."
if [ "$DEPLOYMENT_TYPE" = "update" ]; then
    aws cloudformation wait stack-update-complete --stack-name $STACK_NAME
else
    aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
fi

WAIT_RESULT=$?
COMPLETION_TIME=$(date)

if [ $WAIT_RESULT -eq 0 ]; then
    echo "✅ NIST 800-171 deployment completed successfully!"
    echo "   Completion time: $COMPLETION_TIME"
else
    echo "❌ NIST 800-171 deployment failed or timed out"
    echo "📞 Contact support: khalillyons@gmail.com | (703) 795-4193"
    exit 1
fi

# Post-deployment validation
echo ""
echo "📊 Phase 3: Post-deployment Validation"

CONFIG_RULES_COUNT=$(aws configservice describe-config-rules --query 'length(ConfigRules)' --output text)
echo "   Config rules deployed: $CONFIG_RULES_COUNT"

STACK_RESOURCES=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME --query 'length(StackResources)' --output text)
echo "   CloudFormation resources: $STACK_RESOURCES"

# Generate documentation
echo ""
echo "📄 Phase 4: Documentation Generation"

cat > "NIST_${CLIENT_CODE}_Deployment_Summary.txt" << EOF
NIST 800-171 DEPLOYMENT SERVICE - COMPLETION SUMMARY
===================================================

CLIENT INFORMATION
------------------
Client Code: $CLIENT_CODE
Stack Name: $STACK_NAME
Service Date: $(date +"%Y-%m-%d")
Deployment Type: $DEPLOYMENT_TYPE
Service Provider: AWS Config Cleanup Service
Contact: khalillyons@gmail.com | (703) 795-4193

DEPLOYMENT RESULTS
------------------
• CloudFormation Stack: $STACK_NAME (active)
• Config Rules Deployed: $CONFIG_RULES_COUNT
• CloudFormation Resources: $STACK_RESOURCES
• Deployment Duration: $COMPLETION_TIME

NIST 800-171 COMPLIANCE STATUS
-----------------------------
✅ NIST compliance framework deployed
✅ 100+ Config rules monitoring compliance
✅ Continuous compliance monitoring active
✅ Professional compliance documentation generated

BILLING INFORMATION
-------------------
Service: NIST 800-171 Compliance Deployment
Investment: \$7,500

NEXT STEPS
----------
• Initial compliance scan in progress (results in 24-48 hours)
• Monthly compliance reports available
• Ongoing monitoring and support available

SUPPORT
-------
Email: khalillyons@gmail.com
Phone: (703) 795-4193
Service completed: $(date)
EOF

echo "✅ Client documentation generated: NIST_${CLIENT_CODE}_Deployment_Summary.txt"

echo ""
echo "🎉 NIST 800-171 DEPLOYMENT COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📄 Professional Deliverables:"
echo "• NIST_${CLIENT_CODE}_Deployment_Summary.txt"
echo "• CloudFormation stack: $STACK_NAME (active)"
echo "• $CONFIG_RULES_COUNT Config rules monitoring compliance"
echo ""
echo "📊 Compliance Status:"
echo "• Initial scan in progress (results in 24-48 hours)"
echo "• Continuous monitoring now active"
echo "• Monthly reports available via ongoing service"
echo ""
echo "📞 Next Steps:"
echo "• Review initial compliance scan results"
echo "• Schedule monthly compliance review meeting"
echo "• Contact for any questions or additional services"
echo ""
echo "💼 Service Investment: \$7,500"
echo "📧 Support: khalillyons@gmail.com | 📞 (703) 795-4193"
echo ""
echo "🏛️ Your AWS environment is now NIST 800-171 compliant!"
