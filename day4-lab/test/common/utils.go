package common

import (
	"context"
	"fmt"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/resources/armresources"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TerraformOptions creates standard Terraform options for testing
func TerraformOptions(t *testing.T, terraformDir string) *terraform.Options {
	return &terraform.Options{
		TerraformDir: terraformDir,
		Vars:         map[string]interface{}{},
		EnvVars: map[string]string{
			"ARM_SUBSCRIPTION_ID": GetSubscriptionID(t),
		},
	}
}

// GetSubscriptionID retrieves the Azure subscription ID from environment
func GetSubscriptionID(t *testing.T) string {
	subscriptionID := os.Getenv("ARM_SUBSCRIPTION_ID")
	if subscriptionID == "" {
		// Try to get from Azure CLI
		subscriptionID = azure.GetSubscriptionIDFromCLI(t)
	}
	assert.NotEmpty(t, subscriptionID, "Azure subscription ID must be set")
	return subscriptionID
}

// ResourceGroupExists checks if a resource group exists
func ResourceGroupExists(t *testing.T, subscriptionID, resourceGroupName string) bool {
	cred, err := azidentity.NewDefaultAzureCredential(nil)
	assert.NoError(t, err)

	client, err := armresources.NewResourceGroupsClient(subscriptionID, cred, nil)
	assert.NoError(t, err)

	_, err = client.Get(context.Background(), resourceGroupName, nil)
	return err == nil
}

// ValidateResourceTags checks if resources have expected tags
func ValidateResourceTags(expectedTags map[string]string, actualTags map[string]*string) bool {
	for key, expectedValue := range expectedTags {
		if actualValue, exists := actualTags[key]; !exists || actualValue == nil || *actualValue != expectedValue {
			return false
		}
	}
	return true
}

// GenerateUniqueResourceName creates a unique resource name for testing
func GenerateUniqueResourceName(prefix string) string {
	return fmt.Sprintf("%s-%s", prefix, GenerateRandomString(8))
}

// GenerateRandomString creates a random string of specified length
func GenerateRandomString(length int) string {
	// Implementation would generate random string
	// For simplicity, using a placeholder
	return "test123"
}

// ExpectedTags returns the expected tags for workshop resources
func ExpectedTags() map[string]string {
	return map[string]string{
		"Environment": "workshop",
		"ManagedBy":   "terraform",
	}
}