# Sprint 4 - App Service Plan & App Service

This module creates Azure App Service Plan and App Service with a Hello World application.

## Overview

Creates:
- App Service Plan
- App Service (Web App)
- App Service configuration with Key Vault integration
- Hello World application deployment

## Prerequisites

- Sprint 1 (00-backend) completed
- Sprint 2 (01-network) completed
- Sprint 3 (02-keyvault) completed
- Backend configuration set up

## Usage

1. Configure backend using outputs from Sprint 1
2. Initialize and apply:
```bash
terraform init
terraform plan  # Should show 3 resources being created
terraform apply
```

3. Test the deployment:
```bash
curl <app-url>  # Should return HTTP 200
```

## Definition of Done ✅

- `terraform apply` creates/updates resources and deployment succeeds
- Browser shows "Hello World – DB OK"
- `terraform apply` creates **3 resources**
- `curl <app-url>` returns HTTP 200
- Tests & docs pass

## Resources Created

This module creates exactly **3 resources** as required:
1. `azurerm_service_plan.main` - App Service Plan
2. `azurerm_linux_web_app.main` - Linux Web App
3. `azurerm_app_service_source_control.main` - Source control for app deployment

## Outputs

- `app_service_name` - Name of the App Service
- `app_service_url` - URL of the App Service
- `app_service_identity` - Managed identity of the App Service

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->