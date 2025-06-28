#!/bin/bash

# Cleanup script for Terraform backend bootstrap
# Use this script to remove the bootstrap resources if needed

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if resource group name is provided
if [ $# -eq 0 ]; then
    log_error "Usage: $0 <resource-group-name>"
    log_info "Example: $0 terraform-backend-a1b2c3d4"
    exit 1
fi

RESOURCE_GROUP_NAME=$1

# Confirm deletion
log_warning "This will DELETE the resource group '$RESOURCE_GROUP_NAME' and ALL its resources!"
log_warning "This action cannot be undone."
echo
read -p "Are you sure you want to continue? (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
    log_info "Cleanup cancelled."
    exit 0
fi

# Check if Azure CLI is installed and logged in
if ! command -v az &> /dev/null; then
    log_error "Azure CLI is not installed."
    exit 1
fi

if ! az account show &> /dev/null; then
    log_error "Not logged in to Azure. Please run 'az login' first."
    exit 1
fi

# Check if resource group exists
if ! az group show --name "$RESOURCE_GROUP_NAME" &> /dev/null; then
    log_error "Resource group '$RESOURCE_GROUP_NAME' does not exist."
    exit 1
fi

# Delete resource group
log_info "Deleting resource group: $RESOURCE_GROUP_NAME"
az group delete --name "$RESOURCE_GROUP_NAME" --yes --no-wait

log_success "Resource group deletion initiated. This may take a few minutes to complete."
log_info "You can check the progress in the Azure portal or with: az group show --name $RESOURCE_GROUP_NAME"

# Clean up generated files
log_info "Cleaning up generated files..."
rm -f backend-config.tf terraform.tfvars migration-instructions.md

log_success "Cleanup completed!"
log_warning "Remember to remove any backend configuration from your Terraform files."