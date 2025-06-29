#!/bin/bash

# Example script showing how to use the bootstrap solution
# This script demonstrates the complete workflow from bootstrap to fully managed Terraform backend

set -e

echo "=== Terraform Backend Bootstrap Example ==="
echo

# Step 1: Bootstrap
echo "Step 1: Running bootstrap script..."
cd bootstrap/
./bootstrap.sh

echo
echo "Step 2: Review generated files..."
ls -la *.tf *.md 2>/dev/null || echo "Files will be generated in the bootstrap directory"

echo
echo "Step 3: Next steps to complete the setup:"
echo "1. Copy the generated backend-config.tf content to your main.tf"
echo "2. Use the generated terraform.tfvars file"
echo "3. Follow the migration-instructions.md file"

echo
echo "=== Bootstrap completed! ==="
echo "Check the migration-instructions.md file for detailed next steps."