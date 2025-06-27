# Test Suite for Terraform Workshop

This directory contains automated tests for validating the Terraform workshop infrastructure.

## Overview

The test suite validates:
- Resource existence and configuration
- Network connectivity
- Security configurations
- Application functionality
- End-to-end integration

## Prerequisites

- Go 1.19+
- Terratest library
- Azure CLI authenticated
- Terraform modules deployed

## Running Tests

### All Tests
```bash
cd day4-lab/test
go test -v ./...
```

### Specific Module Tests
```bash
# Backend tests
go test -v ./backend

# Network tests  
go test -v ./network

# Key Vault tests
go test -v ./keyvault

# App Service tests
go test -v ./app

# Database tests
go test -v ./data
```

### Integration Tests
```bash
go test -v ./integration
```

## Test Structure

```
test/
├── backend/     # Sprint 1 tests
├── network/     # Sprint 2 tests
├── keyvault/    # Sprint 3 tests
├── app/         # Sprint 4 tests
├── data/        # Sprint 5 tests
├── integration/ # End-to-end tests
└── common/      # Shared test utilities
```

## Test Output

Tests generate `test.out` file with detailed results for review.

## CI/CD Integration

Tests can be integrated into CI/CD pipelines for automated validation.