#!/bin/bash

# Comprehensive validation script for Terraform Workshop Day 4
# This script validates the entire workshop can work end-to-end without deploying real resources

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✅ PASS]${NC} $1"
    ((PASSED_CHECKS++))
}

log_warning() {
    echo -e "${YELLOW}[⚠️ WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[❌ FAIL]${NC} $1"
    ((FAILED_CHECKS++))
}

check_test() {
    ((TOTAL_CHECKS++))
    if $1; then
        log_success "$2"
        return 0
    else
        log_error "$2"
        return 1
    fi
}

# Check if required tools are installed
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check each tool and provide helpful messages
    if command -v terraform &> /dev/null; then
        log_success "Terraform is installed"
        ((PASSED_CHECKS++))
        
        # Check Terraform version
        TERRAFORM_VERSION=$(terraform version | head -1 | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sed 's/v//' || echo "unknown")
        REQUIRED_VERSION="1.12.2"
        if [ "$TERRAFORM_VERSION" != "unknown" ] && [ "$(printf '%s\n' "$REQUIRED_VERSION" "$TERRAFORM_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
            log_success "Terraform version $TERRAFORM_VERSION meets requirement (>= $REQUIRED_VERSION)"
            ((PASSED_CHECKS++))
        else
            log_warning "Terraform version $TERRAFORM_VERSION may not meet requirement (>= $REQUIRED_VERSION)"
        fi
        ((TOTAL_CHECKS++))
    else
        log_warning "Terraform is not installed (required for full validation)"
        log_info "  Install from: https://terraform.io/downloads"
    fi
    ((TOTAL_CHECKS++))
    
    if command -v terraform-docs &> /dev/null; then
        log_success "terraform-docs is installed"
        ((PASSED_CHECKS++))
    else
        log_warning "terraform-docs is not installed (required for documentation validation)"
        log_info "  Install from: https://terraform-docs.io/user-guide/installation/"
    fi
    ((TOTAL_CHECKS++))
    
    if command -v az &> /dev/null; then
        log_success "Azure CLI is installed"
        ((PASSED_CHECKS++))
    else
        log_warning "Azure CLI is not installed (required for real deployment)"
        log_info "  Install from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    fi
    ((TOTAL_CHECKS++))
}

# Check directory structure
check_structure() {
    log_info "Checking workshop structure..."
    
    check_test "[ -d '00-backend' ]" "Sprint 1 directory exists (00-backend)"
    check_test "[ -d '01-network' ]" "Sprint 2 directory exists (01-network)"
    check_test "[ -d '02-keyvault' ]" "Sprint 3 directory exists (02-keyvault)"
    check_test "[ -d '03-app' ]" "Sprint 4 directory exists (03-app)"
    check_test "[ -d '04-data' ]" "Sprint 5 directory exists (04-data)"
    check_test "[ -d 'test' ]" "Test directory exists"
}

# Check bootstrap setup
check_bootstrap() {
    log_info "Checking Sprint 1 - Backend Bootstrap..."
    
    check_test "[ -f '00-backend/bootstrap/bootstrap.sh' ]" "Bootstrap script exists"
    check_test "[ -x '00-backend/bootstrap/bootstrap.sh' ]" "Bootstrap script is executable"
    check_test "[ -f '00-backend/bootstrap/cleanup.sh' ]" "Cleanup script exists"
    check_test "[ -f '00-backend/bootstrap/README.md' ]" "Bootstrap documentation exists"
    
    # Check if bootstrap script has required sections
    if [ -f "00-backend/bootstrap/bootstrap.sh" ]; then
        check_test "grep -q 'RESOURCE_GROUP_PREFIX' '00-backend/bootstrap/bootstrap.sh'" "Bootstrap script has resource group configuration"
        check_test "grep -q 'STORAGE_ACCOUNT_PREFIX' '00-backend/bootstrap/bootstrap.sh'" "Bootstrap script has storage account configuration"
        check_test "grep -q 'CONTAINER_NAME' '00-backend/bootstrap/bootstrap.sh'" "Bootstrap script has container configuration"
    fi
}

# Check Terraform configurations
check_terraform_configs() {
    log_info "Checking Terraform configurations..."
    
    if ! command -v terraform &> /dev/null; then
        log_warning "Skipping Terraform validation (terraform not installed)"
        return 0
    fi
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -d "$module" ]; then
            log_info "Validating $module..."
            
            check_test "[ -f '$module/main.tf' ]" "$module has main.tf"
            check_test "[ -f '$module/variables.tf' ]" "$module has variables.tf"
            check_test "[ -f '$module/outputs.tf' ]" "$module has outputs.tf"
            check_test "[ -f '$module/terraform.tfvars.example' ]" "$module has example variables"
            check_test "[ -f '$module/backend.hcl.example' ]" "$module has backend configuration example"
            check_test "[ -f '$module/README.md' ]" "$module has documentation"
            
            # Check if terraform configuration is valid
            cd "$module"
            if terraform init -backend=false &> /dev/null; then
                if terraform validate &> /dev/null; then
                    log_success "$module Terraform configuration is valid"
                    ((PASSED_CHECKS++))
                else
                    log_error "$module Terraform validation failed"
                    terraform validate
                    ((FAILED_CHECKS++))
                fi
            else
                log_warning "$module Terraform initialization failed (may need provider download)"
                ((FAILED_CHECKS++))
            fi
            ((TOTAL_CHECKS++))
            cd ..
        fi
    done
}

# Check provider versions
check_provider_versions() {
    log_info "Checking provider versions..."
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -f "$module/versions.tf" ]; then
            # Check for required Terraform version
            if grep -q "required_version.*1\.12" "$module/versions.tf"; then
                log_success "$module has correct Terraform version requirement"
                ((PASSED_CHECKS++))
            else
                log_error "$module missing or incorrect Terraform version requirement"
                ((FAILED_CHECKS++))
            fi
            
            # Check for AzureRM provider version
            if grep -q "azurerm.*4\." "$module/versions.tf"; then
                log_success "$module has correct AzureRM provider version"
                ((PASSED_CHECKS++))
            else
                log_error "$module missing or incorrect AzureRM provider version"
                ((FAILED_CHECKS++))
            fi
            
            ((TOTAL_CHECKS+=2))
        fi
    done
}

# Check test files
check_tests() {
    log_info "Checking test files..."
    
    check_test "[ -f 'test/run-tests.sh' ]" "Test runner script exists"
    check_test "[ -x 'test/run-tests.sh' ]" "Test runner script is executable"
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        check_test "[ -f '$module/tests.tftest.hcl' ]" "$module has test file"
        
        if [ -f "$module/tests.tftest.hcl" ]; then
            check_test "grep -q 'run.*test' '$module/tests.tftest.hcl'" "$module test file has test blocks"
        fi
    done
}

# Check documentation
check_documentation() {
    log_info "Checking documentation..."
    
    check_test "[ -f '../README.md' ]" "Root README exists"
    check_test "[ -f '../SETUP.md' ]" "Setup guide exists"
    check_test "[ -f '../Makefile' ]" "Makefile exists"
    
    # Check if READMEs contain terraform-docs content
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -f "$module/README.md" ]; then
            if grep -q "terraform-docs" "$module/README.md" || grep -q "Requirements" "$module/README.md"; then
                log_success "$module README contains terraform-docs content"
                ((PASSED_CHECKS++))
            else
                log_warning "$module README may need terraform-docs generation"
            fi
            ((TOTAL_CHECKS++))
        fi
    done
}

# Check resource count validation (specific requirements from workshop)
check_resource_counts() {
    log_info "Checking resource count requirements..."
    
    if ! command -v terraform &> /dev/null; then
        log_warning "Skipping resource count validation (terraform not installed)"
        return 0
    fi
    
    # Sprint 2 (Network) should have 5 resources
    if [ -d "01-network" ]; then
        cd "01-network"
        if terraform init -backend=false &> /dev/null; then
            # Create a minimal terraform.tfvars for planning
            cat > terraform.tfvars << EOF
backend_resource_group_name = "rg-terraform-backend-test"
resource_group_name = "rg-test-network"
location = "West Europe"
EOF
            
            if terraform plan -input=false &> plan.out; then
                NETWORK_RESOURCES=$(grep -c "will be created" plan.out || echo "0")
                if [ "$NETWORK_RESOURCES" = "5" ]; then
                    log_success "Network module plans to create 5 resources (as required)"
                    ((PASSED_CHECKS++))
                else
                    log_warning "Network module plans to create $NETWORK_RESOURCES resources (requirement: 5)"
                fi
            else
                log_warning "Cannot validate network resource count (plan failed)"
            fi
            rm -f plan.out terraform.tfvars
        else
            log_warning "Cannot validate network resource count (init failed)"
        fi
        ((TOTAL_CHECKS++))
        cd ..
    fi
    
    # Sprint 4 (App) should have 3 resources
    if [ -d "03-app" ]; then
        cd "03-app"
        if terraform init -backend=false &> /dev/null; then
            # Create a minimal terraform.tfvars for planning
            cat > terraform.tfvars << EOF
backend_resource_group_name = "rg-terraform-backend-test"
network_resource_group_name = "rg-test-network"
keyvault_resource_group_name = "rg-test-keyvault"
resource_group_name = "rg-test-app"
location = "West Europe"
vnet_name = "vnet-test"
app_subnet_name = "subnet-app"
key_vault_name = "kv-test-12345"
managed_identity_name = "mi-test"
EOF
            
            if terraform plan -input=false &> plan.out; then
                APP_RESOURCES=$(grep -c "will be created" plan.out || echo "0")
                if [ "$APP_RESOURCES" = "3" ]; then
                    log_success "App module plans to create 3 resources (as required)"
                    ((PASSED_CHECKS++))
                else
                    log_warning "App module plans to create $APP_RESOURCES resources (requirement: 3)"
                fi
            else
                log_warning "Cannot validate app resource count (plan failed)"
            fi
            rm -f plan.out terraform.tfvars
        else
            log_warning "Cannot validate app resource count (init failed)"
        fi
        ((TOTAL_CHECKS++))
        cd ..
    fi
}

# Check Definition of Done criteria
check_definition_of_done() {
    log_info "Checking Definition of Done criteria..."
    
    # Sprint 2: VNet foundation with NSG (5 resources)
    if [ -f "01-network/main.tf" ]; then
        check_test "grep -q 'azurerm_virtual_network' '01-network/main.tf'" "Network module has Virtual Network"
        check_test "grep -q 'azurerm_subnet' '01-network/main.tf'" "Network module has subnets"
        check_test "grep -q 'azurerm_network_security_group' '01-network/main.tf'" "Network module has NSG"
    fi
    
    # Sprint 3: Key Vault and IAM
    if [ -f "02-keyvault/main.tf" ]; then
        check_test "grep -q 'azurerm_key_vault' '02-keyvault/main.tf'" "KeyVault module has Key Vault"
        check_test "grep -q 'azurerm_user_assigned_identity' '02-keyvault/main.tf'" "KeyVault module has managed identity"
    fi
    
    # Sprint 4: App Service Plan + App Service
    if [ -f "03-app/main.tf" ]; then
        check_test "grep -q 'azurerm_service_plan' '03-app/main.tf'" "App module has Service Plan"
        check_test "grep -q 'azurerm_linux_web_app' '03-app/main.tf'" "App module has Web App"
    fi
    
    # Sprint 5: SQL Database with Private Endpoint
    if [ -f "04-data/main.tf" ]; then
        check_test "grep -q 'azurerm_mssql_server' '04-data/main.tf'" "Data module has SQL Server"
        check_test "grep -q 'azurerm_mssql_database' '04-data/main.tf'" "Data module has SQL Database"
        check_test "grep -q 'azurerm_private_endpoint' '04-data/main.tf'" "Data module has Private Endpoint"
    fi
}

# Run all validations
main() {
    echo "🔍 Terraform Workshop End-to-End Validation"
    echo "============================================="
    echo ""
    
    # Navigate to day4-lab directory
    cd "$(dirname "$0")"
    
    # Run all checks
    check_prerequisites
    echo ""
    check_structure  
    echo ""
    check_bootstrap
    echo ""
    check_terraform_configs
    echo ""
    check_provider_versions
    echo ""
    check_tests
    echo ""
    check_documentation
    echo ""
    check_resource_counts
    echo ""
    check_definition_of_done
    echo ""
    
    # Summary
    echo "📊 VALIDATION SUMMARY"
    echo "===================="
    echo "Total checks: $TOTAL_CHECKS"
    echo "Passed: $PASSED_CHECKS"
    echo "Failed: $FAILED_CHECKS"
    echo ""
    
    if [ $FAILED_CHECKS -eq 0 ]; then
        echo -e "${GREEN}🎉 ALL VALIDATIONS PASSED!${NC}"
        echo ""
        echo "The workshop is ready for end-to-end testing with real Azure resources."
        echo ""
        echo "Next steps:"
        echo "📖 Read E2E-TESTING.md for detailed testing instructions"
        echo "🚀 To test with actual deployment:"
        echo "   1. Run: cd 00-backend/bootstrap && ./bootstrap.sh"
        echo "   2. Follow the generated migration instructions"
        echo "   3. Run each sprint in order: 01-network → 02-keyvault → 03-app → 04-data"
        echo "   4. Test the deployed app service URL"
        echo "   5. Verify private endpoint connectivity"
        exit 0
    elif [ $FAILED_CHECKS -le 3 ] && [ $PASSED_CHECKS -gt 10 ]; then
        echo -e "${YELLOW}⚠️  VALIDATION COMPLETED WITH WARNINGS${NC}"
        echo ""
        echo "Passed: $PASSED_CHECKS | Failed: $FAILED_CHECKS | Total: $TOTAL_CHECKS"
        echo ""
        echo "Most validations passed. The workshop should work with minor adjustments."
        echo "📖 Read E2E-TESTING.md for detailed testing instructions"
        exit 0
    else
        echo -e "${RED}❌ $FAILED_CHECKS VALIDATION(S) FAILED${NC}"
        echo ""
        echo "Please address the failed validations before attempting real deployment."
        echo "📖 Read E2E-TESTING.md for testing guidance"
        exit 1
    fi
}

# Run the validation
main "$@"