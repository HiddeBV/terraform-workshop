package backend

import (
	"testing"

	"terraform-workshop-test/common"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBackendModule(t *testing.T) {
	t.Parallel()

	// Setup Terraform options
	terraformOptions := common.TerraformOptions(t, "../../00-backend")

	// Cleanup resources after test
	defer terraform.Destroy(t, terraformOptions)

	// Deploy the infrastructure
	terraform.InitAndApply(t, terraformOptions)

	// Validate outputs
	validateBackendOutputs(t, terraformOptions)

	// Validate resource existence
	validateBackendResources(t, terraformOptions)
}

func validateBackendOutputs(t *testing.T, terraformOptions *terraform.Options) {
	// Get outputs
	storageAccountName := terraform.Output(t, terraformOptions, "storage_account_name")
	containerName := terraform.Output(t, terraformOptions, "container_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")

	// Validate outputs are not empty
	assert.NotEmpty(t, storageAccountName, "Storage account name should not be empty")
	assert.NotEmpty(t, containerName, "Container name should not be empty")
	assert.NotEmpty(t, resourceGroupName, "Resource group name should not be empty")

	// Validate naming conventions
	assert.Contains(t, storageAccountName, "stterraform", "Storage account should contain prefix")
	assert.Equal(t, "tfstate", containerName, "Container name should be tfstate")
	assert.Contains(t, resourceGroupName, "rg-terraform-backend", "Resource group should contain prefix")
}

func validateBackendResources(t *testing.T, terraformOptions *terraform.Options) {
	subscriptionID := common.GetSubscriptionID(t)
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	storageAccountName := terraform.Output(t, terraformOptions, "storage_account_name")

	// Validate resource group exists
	assert.True(t, 
		common.ResourceGroupExists(t, subscriptionID, resourceGroupName), 
		"Resource group should exist",
	)

	// Validate storage account exists
	assert.True(t, 
		azure.StorageAccountExists(t, storageAccountName, resourceGroupName, subscriptionID), 
		"Storage account should exist",
	)

	// Validate storage container exists
	containerName := terraform.Output(t, terraformOptions, "container_name")
	assert.True(t, 
		azure.StorageBlobContainerExists(t, containerName, storageAccountName, resourceGroupName, subscriptionID), 
		"Storage container should exist",
	)
}

func TestBackendInitialization(t *testing.T) {
	t.Parallel()

	terraformOptions := common.TerraformOptions(t, "../../00-backend")

	// Test terraform init
	terraform.Init(t, terraformOptions)

	// Validate that initialization was successful
	// This is implicitly tested by the Init function not failing
	assert.True(t, true, "Terraform initialization should succeed")
}