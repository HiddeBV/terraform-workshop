#!/bin/bash

# Test runner script for Terraform Workshop
# This script runs Terraform tests and generates test.out file

set -e

echo "Starting Terraform Workshop Tests..."
echo "===================================="

# Create test output directory
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSHOP_DIR="$(dirname "$TEST_DIR")"
OUTPUT_FILE="$TEST_DIR/test.out"

# Clear previous test output
> "$OUTPUT_FILE"

# Function to run tests for a module
run_module_tests() {
    local module=$1
    local module_dir="$WORKSHOP_DIR/$module"
    
    echo "Running tests for $module..." | tee -a "$OUTPUT_FILE"
    
    if [ -d "$module_dir" ] && [ -f "$module_dir/tests.tftest.hcl" ]; then
        cd "$module_dir"
        if terraform init >> "$OUTPUT_FILE" 2>&1 && terraform test >> "$OUTPUT_FILE" 2>&1; then
            echo "✅ $module tests PASSED" | tee -a "$OUTPUT_FILE"
        else
            echo "❌ $module tests FAILED" | tee -a "$OUTPUT_FILE"
            return 1
        fi
    else
        echo "⚠️  $module test file not found" | tee -a "$OUTPUT_FILE"
    fi
    echo "" | tee -a "$OUTPUT_FILE"
}

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed. Please install Terraform 1.6+ to run tests." | tee -a "$OUTPUT_FILE"
    exit 1
fi

# Check Terraform version (tests require Terraform 1.6+)
TERRAFORM_VERSION=$(terraform version -json | grep -o '"version":"[^"]*' | grep -o '[^"]*$' | head -1)
echo "Using Terraform version: $TERRAFORM_VERSION" | tee -a "$OUTPUT_FILE"

# Convert module names to their directory names
declare -A MODULE_DIRS=(
    ["backend"]="00-backend"
    ["network"]="01-network"
    ["keyvault"]="02-keyvault"
    ["app"]="03-app"
    ["data"]="04-data"
)

# Run tests for each module in order
MODULES=("backend" "network" "keyvault" "app" "data")
FAILED_MODULES=()

for module in "${MODULES[@]}"; do
    module_dir="${MODULE_DIRS[$module]}"
    if ! run_module_tests "$module_dir"; then
        FAILED_MODULES+=("$module")
    fi
done

# Summary
echo "" | tee -a "$OUTPUT_FILE"
echo "Test Summary:" | tee -a "$OUTPUT_FILE"
echo "=============" | tee -a "$OUTPUT_FILE"

if [ ${#FAILED_MODULES[@]} -eq 0 ]; then
    echo "🎉 All tests PASSED!" | tee -a "$OUTPUT_FILE"
    exit 0
else
    echo "❌ Failed modules: ${FAILED_MODULES[*]}" | tee -a "$OUTPUT_FILE"
    echo "📋 Check $OUTPUT_FILE for detailed results." | tee -a "$OUTPUT_FILE"
    exit 1
fi