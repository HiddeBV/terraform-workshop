#!/bin/bash

# Documentation generator for Terraform Workshop
# This script simulates terraform-docs output for each module

set -e

WORKSHOP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to update README with terraform-docs content
update_module_docs() {
    local module_dir=$1
    local module_name=$2
    
    echo "Updating docs for $module_name..."
    
    if [ ! -f "$module_dir/README.md" ]; then
        echo "README.md not found in $module_dir"
        return 1
    fi
    
    # Create temporary terraform-docs content
    cat > /tmp/terraform-docs-$module_name.md << EOF

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Resources

$(if [ -f "$module_dir/main.tf" ]; then
    grep -E '^resource "' "$module_dir/main.tf" | sed 's/resource "/| /' | sed 's/" .*//' | while read line; do
        echo "$line | resource |"
    done
fi)

## Inputs

$(if [ -f "$module_dir/variables.tf" ]; then
    grep -A 3 -E '^variable "' "$module_dir/variables.tf" | while IFS= read -r line; do
        if [[ "$line" =~ ^variable\ \"(.*)\" ]]; then
            var_name="${BASH_REMATCH[1]}"
            echo "| <a name=\"input_$var_name\"></a> [$var_name](#input\_$var_name) | n/a | no |"
        fi
    done
fi)

## Outputs

$(if [ -f "$module_dir/outputs.tf" ]; then
    grep -E '^output "' "$module_dir/outputs.tf" | sed 's/output "/| /' | sed 's/" {//' | while read line; do
        echo "$line | n/a |"
    done
fi)

EOF

    # Replace the terraform-docs section in README
    if grep -q "<!-- BEGIN_TF_DOCS -->" "$module_dir/README.md"; then
        # Use a temporary file for the replacement
        awk '
        /<!-- BEGIN_TF_DOCS -->/ { 
            print; 
            system("cat /tmp/terraform-docs-'$module_name'.md"); 
            while(getline && !/<!-- END_TF_DOCS -->/) {} 
        } 
        { print }
        ' "$module_dir/README.md" > "$module_dir/README.md.tmp"
        
        mv "$module_dir/README.md.tmp" "$module_dir/README.md"
    fi
    
    # Clean up
    rm -f /tmp/terraform-docs-$module_name.md
}

# Update documentation for each module
echo "Generating Terraform documentation..."

update_module_docs "$WORKSHOP_DIR/day4-lab/00-backend" "backend"
update_module_docs "$WORKSHOP_DIR/day4-lab/01-network" "network" 
update_module_docs "$WORKSHOP_DIR/day4-lab/02-keyvault" "keyvault"
update_module_docs "$WORKSHOP_DIR/day4-lab/03-app" "app"
update_module_docs "$WORKSHOP_DIR/day4-lab/04-data" "data"

echo "Documentation generation complete!"
echo "📚 All module READMEs have been updated with Terraform documentation."