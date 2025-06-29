# Test Suite for Terraform Workshop

This directory contains automated tests for validating the Terraform workshop infrastructure using Terraform's native testing framework.

## Overview

The test suite validates:
- Resource existence and configuration
- Network connectivity  
- Security configurations
- Application functionality
- Module integration

## Prerequisites

- Terraform 1.6+ (for native test support)
- Azure CLI authenticated (if running apply tests)
- Access to Azure subscription

## Test Files

Each module contains a `tests.tftest.hcl` file with comprehensive test cases:

```
00-backend/tests.tftest.hcl   # Sprint 1 tests
01-network/tests.tftest.hcl   # Sprint 2 tests  
02-keyvault/tests.tftest.hcl  # Sprint 3 tests
03-app/tests.tftest.hcl       # Sprint 4 tests
04-data/tests.tftest.hcl      # Sprint 5 tests
```

## Running Tests

### All Tests (Automated)
```bash
cd day4-lab/test
./run-tests.sh
```

### Individual Module Tests
```bash
# Backend tests (Sprint 1)
cd day4-lab/00-backend
terraform test

# Network tests (Sprint 2)
cd day4-lab/01-network  
terraform test

# Key Vault tests (Sprint 3)
cd day4-lab/02-keyvault
terraform test

# App Service tests (Sprint 4)
cd day4-lab/03-app
terraform test

# Database tests (Sprint 5)
cd day4-lab/04-data
terraform test
```

## Test Types

### Plan Tests
- Validate resource configuration
- Check naming conventions
- Verify variable validation
- Test default and custom values

### Apply Tests (Optional)
- Validate actual resource creation
- Test connectivity and functionality
- Verify security configurations

## Test Output

Tests generate `test.out` file with detailed results for review.

## Benefits of Terraform Tests

- **Native Integration**: No external dependencies like Go or Terratest
- **Fast Execution**: Plan-based tests run quickly without Azure resources
- **Built-in Assertions**: Terraform-native assertion syntax
- **Module Validation**: Direct testing of Terraform configurations
- **CI/CD Ready**: Easy integration into automation pipelines