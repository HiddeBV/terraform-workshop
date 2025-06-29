#!/bin/bash

# Simple validation script for Terraform Workshop Day 4
# This script validates the structure and content without requiring terraform installation

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

# Check directory structure
check_structure() {
    log_info "Checking workshop structure..."
    
    check_test "[ -d '00-backend' ]" "Sprint 1 directory exists (00-backend)"
    check_test "[ -d '01-network' ]" "Sprint 2 directory exists (01-network)"
    check_test "[ -d '02-keyvault' ]" "Sprint 3 directory exists (02-keyvault)"
    check_test "[ -d '03-app' ]" "Sprint 4 directory exists (03-app)"
    check_test "[ -d '04-data' ]" "Sprint 5 directory exists (04-data)"
    check_test "[ -d 'test' ]" "Test directory exists"
    check_test "[ -f 'E2E-TESTING.md' ]" "End-to-end testing guide exists"
    check_test "[ -f 'validate-workshop.sh' ]" "Validation script exists"
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

# Check required files exist
check_terraform_files() {
    log_info "Checking Terraform file structure..."
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -d "$module" ]; then
            log_info "Checking $module files..."
            
            check_test "[ -f '$module/main.tf' ]" "$module has main.tf"
            check_test "[ -f '$module/variables.tf' ]" "$module has variables.tf"
            check_test "[ -f '$module/outputs.tf' ]" "$module has outputs.tf"
            check_test "[ -f '$module/versions.tf' ]" "$module has versions.tf"
            check_test "[ -f '$module/terraform.tfvars.example' ]" "$module has example variables"
            check_test "[ -f '$module/backend.hcl.example' ]" "$module has backend configuration example"
            check_test "[ -f '$module/README.md' ]" "$module has documentation"
            check_test "[ -f '$module/tests.tftest.hcl' ]" "$module has test file"
        fi
    done
}

# Check provider versions in files
check_provider_versions() {
    log_info "Checking provider versions in files..."
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -f "$module/versions.tf" ]; then
            # Check for required Terraform version
            if grep -q "required_version.*1\.12" "$module/versions.tf"; then
                log_success "$module has correct Terraform version requirement (>= 1.12)"
                ((PASSED_CHECKS++))
            else
                log_error "$module missing or incorrect Terraform version requirement"
                ((FAILED_CHECKS++))
            fi
            
            # Check for AzureRM provider version
            if grep -q "azurerm.*4\." "$module/versions.tf"; then
                log_success "$module has AzureRM provider v4.x"
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
        if [ -f "$module/tests.tftest.hcl" ]; then
            check_test "grep -q 'run.*test' '$module/tests.tftest.hcl'" "$module test file has test blocks"
        fi
    done
}

# Check documentation files
check_documentation() {
    log_info "Checking documentation..."
    
    check_test "[ -f '../README.md' ]" "Root README exists"
    check_test "[ -f '../SETUP.md' ]" "Setup guide exists"
    check_test "[ -f '../Makefile' ]" "Makefile exists"
    
    # Check if READMEs have basic content
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -f "$module/README.md" ]; then
            if grep -q "Requirements\|Usage\|Inputs\|Outputs" "$module/README.md"; then
                log_success "$module README has structured content"
                ((PASSED_CHECKS++))
            else
                log_warning "$module README may need terraform-docs generation"
            fi
            ((TOTAL_CHECKS++))
        fi
    done
}

# Check Definition of Done criteria by examining code
check_definition_of_done() {
    log_info "Checking Definition of Done criteria..."
    
    # Sprint 2: VNet foundation with NSG (5 resources)
    if [ -f "01-network/main.tf" ]; then
        check_test "grep -q 'azurerm_virtual_network' '01-network/main.tf'" "Network module has Virtual Network"
        check_test "grep -q 'azurerm_subnet' '01-network/main.tf'" "Network module has subnets"
        check_test "grep -q 'azurerm_network_security_group' '01-network/main.tf'" "Network module has NSG"
        check_test "grep -q 'azurerm_subnet_network_security_group_association' '01-network/main.tf'" "Network module has NSG association"
        
        # Count resource blocks
        RESOURCE_COUNT=$(grep -c "^resource " "01-network/main.tf" || echo "0")
        if [ "$RESOURCE_COUNT" -eq 5 ]; then
            log_success "Network module has exactly 5 resource blocks"
            ((PASSED_CHECKS++))
        else
            log_warning "Network module has $RESOURCE_COUNT resource blocks (expected: 5)"
        fi
        ((TOTAL_CHECKS++))
    fi
    
    # Sprint 3: Key Vault and IAM
    if [ -f "02-keyvault/main.tf" ]; then
        check_test "grep -q 'azurerm_key_vault' '02-keyvault/main.tf'" "KeyVault module has Key Vault"
        check_test "grep -q 'azurerm_user_assigned_identity' '02-keyvault/main.tf'" "KeyVault module has managed identity"
        check_test "grep -q 'azurerm_key_vault_access_policy' '02-keyvault/main.tf'" "KeyVault module has access policies"
    fi
    
    # Sprint 4: App Service Plan + App Service (3 resources)
    if [ -f "03-app/main.tf" ]; then
        check_test "grep -q 'azurerm_service_plan' '03-app/main.tf'" "App module has Service Plan"
        check_test "grep -q 'azurerm_linux_web_app' '03-app/main.tf'" "App module has Web App"
        check_test "grep -q 'azurerm_app_service_virtual_network_swift_connection' '03-app/main.tf'" "App module has VNet integration"
        
        # Count resource blocks  
        RESOURCE_COUNT=$(grep -c "^resource " "03-app/main.tf" || echo "0")
        if [ "$RESOURCE_COUNT" -eq 3 ]; then
            log_success "App module has exactly 3 resource blocks"
            ((PASSED_CHECKS++))
        else
            log_warning "App module has $RESOURCE_COUNT resource blocks (expected: 3)"
        fi
        ((TOTAL_CHECKS++))
    fi
    
    # Sprint 5: SQL Database with Private Endpoint
    if [ -f "04-data/main.tf" ]; then
        check_test "grep -q 'azurerm_mssql_server' '04-data/main.tf'" "Data module has SQL Server"
        check_test "grep -q 'azurerm_mssql_database' '04-data/main.tf'" "Data module has SQL Database"
        check_test "grep -q 'azurerm_private_endpoint' '04-data/main.tf'" "Data module has Private Endpoint"
        check_test "grep -q 'azurerm_private_dns_zone' '04-data/main.tf'" "Data module has Private DNS Zone"
    fi
}

# Check configuration syntax (basic)
check_basic_syntax() {
    log_info "Checking basic configuration syntax..."
    
    for module in 01-network 02-keyvault 03-app 04-data; do
        if [ -f "$module/main.tf" ]; then
            # Check for basic HCL syntax issues
            if grep -q "^[[:space:]]*resource[[:space:]]" "$module/main.tf"; then
                log_success "$module main.tf has resource blocks"
                ((PASSED_CHECKS++))
            else
                log_error "$module main.tf has no resource blocks"
                ((FAILED_CHECKS++))
            fi
            ((TOTAL_CHECKS++))
            
            # Check for provider block
            if grep -q "azurerm" "$module/main.tf" || grep -q "azurerm" "$module/versions.tf"; then
                log_success "$module has azurerm provider configuration"
                ((PASSED_CHECKS++))
            else
                log_error "$module missing azurerm provider"
                ((FAILED_CHECKS++))
            fi
            ((TOTAL_CHECKS++))
        fi
    done
}

# Run all validations
main() {
    echo "🔍 Terraform Workshop Structure Validation"
    echo "==========================================="
    echo ""
    echo "Note: This validation checks file structure and content without deploying resources."
    echo "For full testing with real Azure resources, see E2E-TESTING.md"
    echo ""
    
    # Navigate to day4-lab directory
    cd "$(dirname "$0")"
    
    # Run all checks
    check_structure
    echo ""
    check_bootstrap
    echo ""
    check_terraform_files
    echo ""
    check_provider_versions
    echo ""
    check_tests
    echo ""
    check_documentation
    echo ""
    check_basic_syntax
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
        echo -e "${GREEN}🎉 ALL STRUCTURAL VALIDATIONS PASSED!${NC}"
        echo ""
        echo "The workshop structure is complete and ready for testing."
        echo ""
        echo "Next steps:"
        echo "📖 Read E2E-TESTING.md for full end-to-end testing instructions"
        echo "🛠️  Install Terraform v1.12.2+ to run advanced validations"
        echo "🚀 With Azure access, run the bootstrap and deploy each sprint"
        exit 0
    elif [ $FAILED_CHECKS -le 3 ] && [ $PASSED_CHECKS -gt 15 ]; then
        echo -e "${YELLOW}⚠️  VALIDATION COMPLETED WITH MINOR ISSUES${NC}"
        echo ""
        echo "Most validations passed. The workshop should work with minor adjustments."
        echo "📖 Read E2E-TESTING.md for detailed testing instructions"
        exit 0
    else
        echo -e "${RED}❌ $FAILED_CHECKS VALIDATION(S) FAILED${NC}"
        echo ""
        echo "Please address the failed validations before attempting deployment."
        echo "📖 Read E2E-TESTING.md for testing guidance"
        exit 1
    fi
}

# Run the validation
main "$@"