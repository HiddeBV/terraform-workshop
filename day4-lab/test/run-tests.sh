#!/bin/bash

# Test runner script for Terraform Workshop
# This script runs tests and generates test.out file

set -e

echo "Starting Terraform Workshop Tests..."
echo "===================================="

# Create test output directory
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$TEST_DIR/test.out"

# Clear previous test output
> "$OUTPUT_FILE"

# Function to run tests for a module
run_module_tests() {
    local module=$1
    echo "Running tests for $module..." | tee -a "$OUTPUT_FILE"
    
    if [ -d "$TEST_DIR/$module" ]; then
        cd "$TEST_DIR/$module"
        if go test -v . >> "$OUTPUT_FILE" 2>&1; then
            echo "✅ $module tests PASSED" | tee -a "$OUTPUT_FILE"
        else
            echo "❌ $module tests FAILED" | tee -a "$OUTPUT_FILE"
            return 1
        fi
    else
        echo "⚠️  $module test directory not found" | tee -a "$OUTPUT_FILE"
    fi
    echo "" | tee -a "$OUTPUT_FILE"
}

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "❌ Go is not installed. Please install Go 1.19+ to run tests." | tee -a "$OUTPUT_FILE"
    exit 1
fi

# Initialize Go modules if needed
cd "$TEST_DIR"
if [ ! -f "go.sum" ]; then
    echo "Initializing Go modules..." | tee -a "$OUTPUT_FILE"
    go mod tidy >> "$OUTPUT_FILE" 2>&1
fi

# Run tests for each module in order
MODULES=("backend" "network" "keyvault" "app" "data")
FAILED_MODULES=()

for module in "${MODULES[@]}"; do
    if ! run_module_tests "$module"; then
        FAILED_MODULES+=("$module")
    fi
done

# Run integration tests if all module tests passed
if [ ${#FAILED_MODULES[@]} -eq 0 ]; then
    echo "Running integration tests..." | tee -a "$OUTPUT_FILE"
    if [ -d "$TEST_DIR/integration" ]; then
        cd "$TEST_DIR/integration"
        if go test -v . >> "$OUTPUT_FILE" 2>&1; then
            echo "✅ Integration tests PASSED" | tee -a "$OUTPUT_FILE"
        else
            echo "❌ Integration tests FAILED" | tee -a "$OUTPUT_FILE"
            FAILED_MODULES+=("integration")
        fi
    fi
fi

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