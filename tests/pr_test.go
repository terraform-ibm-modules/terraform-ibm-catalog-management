// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
	"log"
	"os"
	"strings"
	"testing"
)

// Use existing resource group
const resourceGroup = "geretain-test-resources"
const vpeExampleDir = "examples/vpe-catalog"
const offeringExampleDir = "examples/offering-catalog"
const catalogDAdir = "solutions/catalog"
const vpeDADir = "solutions/vpe-object"

func TestRunOfferingExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  offeringExampleDir,
		Prefix:        "cm",
		Region:        "us-south", // skip region picker
		ResourceGroup: resourceGroup,
		// Need to ignore updated in-place as it is expected due to the fact target account config can only be applied on update, after initial catalog is created.
		IgnoreUpdates: testhelper.Exemptions{
			List: []string{
				"module.catalog.ibm_cm_catalog.cm_catalog",
			},
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunVPEExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: vpeExampleDir,
		Prefix:       "vpe",
		Region:       "us-south", // skip region picker
	})

	options.TerraformVars = map[string]interface{}{
		"prefix":         strings.ReplaceAll(options.Prefix, "-", "_"), // object name cannot have dashes in it
		"resource_group": resourceGroup,
		"tags":           options.Tags,
		"region":         options.Region,
	}

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestCatalogDA(t *testing.T) {
	t.Parallel()

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing: t,
		Region:  "us-south",
		Prefix:  "cat",
		TarIncludePatterns: []string{
			"*.tf",
			catalogDAdir + "/*.tf",
		},
		TemplateFolder:         catalogDAdir,
		Tags:                   []string{"catalog-da"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 60,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "existing_resource_group_name", Value: resourceGroup, DataType: "string"},
		{Name: "label", Value: options.Prefix, DataType: "string"},
		{Name: "tags", Value: options.Tags, DataType: "list(string)"},
	}

	err := options.RunSchematicTest()
	assert.Nil(t, err, "This should not have errored")
}

func TestUpgradeCatalogDA(t *testing.T) {
	t.Parallel()

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing: t,
		Region:  "us-south",
		Prefix:  "cat",
		TarIncludePatterns: []string{
			"*.tf",
			catalogDAdir + "/*.tf",
		},
		TemplateFolder:         catalogDAdir,
		Tags:                   []string{"catalog-da-upg"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 60,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "existing_resource_group_name", Value: resourceGroup, DataType: "string"},
		{Name: "label", Value: options.Prefix, DataType: "string"},
		{Name: "tags", Value: options.Tags, DataType: "list(string)"},
	}

	err := options.RunSchematicUpgradeTest()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
	}
}

func TestVPEDA(t *testing.T) {
	t.Parallel()

	// ------------------------------------------------------------------------------------
	// Provision a catalog first
	// ------------------------------------------------------------------------------------

	prefix := fmt.Sprintf("cat_vpe_da_%s", strings.ToLower(random.UniqueId()))
	realTerraformDir := ".."
	tempTerraformDir, _ := files.CopyTerraformFolderToTemp(realTerraformDir, fmt.Sprintf(prefix+"-%s", strings.ToLower(random.UniqueId())))

	// Verify ibmcloud_api_key variable is set
	checkVariable := "TF_VAR_ibmcloud_api_key"
	val, present := os.LookupEnv(checkVariable)
	require.True(t, present, checkVariable+" environment variable not set")
	require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	logger.Log(t, "Tempdir: ", tempTerraformDir)
	tempDaDir := tempTerraformDir + "/" + catalogDAdir
	// Delete cache
	toDelete := []string{tempDaDir + "/.terraform", tempDaDir + "/.terraform.lock.hcl"}
	for _, s := range toDelete {
		err := os.RemoveAll(s)
		if err != nil {
			log.Printf("failed to remove %s: %v", s, err)
		}
	}
	existingTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempDaDir,
		Vars: map[string]interface{}{
			"existing_resource_group_name": resourceGroup,
			"label":                        prefix,
			"kind":                         "vpe",
		},
		// Set Upgrade to true to ensure latest version of providers and modules are used by terratest.
		// This is the same as setting the -upgrade=true flag with terraform.
		Upgrade: true,
	})

	terraform.WorkspaceSelectOrNew(t, existingTerraformOptions, prefix)
	_, existErr := terraform.InitAndApplyE(t, existingTerraformOptions)
	if existErr != nil {
		assert.True(t, existErr == nil, "Init and Apply of pre-req resources failed in TestVPEDA test")
	} else {
		// ------------------------------------------------------------------------------------
		// Deploy DA
		// ------------------------------------------------------------------------------------
		options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
			Testing: t,
			Region:  "us-south",
			Prefix:  prefix,
			TarIncludePatterns: []string{
				"*.tf",
				"modules/*/*.tf",
				vpeDADir + "/*.tf",
			},
			TemplateFolder:         vpeDADir,
			Tags:                   []string{"cm-vpe-da"},
			DeleteWorkspaceOnFail:  false,
			WaitJobCompleteMinutes: 60,
		})

		options.TerraformVars = []testschematic.TestSchematicTerraformVar{
			{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
			{Name: "catalog_id", Value: terraform.Output(t, existingTerraformOptions, "id"), DataType: "string"},
			{Name: "name", Value: prefix, DataType: "string"},
			{Name: "label", Value: prefix, DataType: "string"},
			{Name: "dns_domain", Value: "example.com", DataType: "string"},
			{Name: "service_crn", Value: "crn:v1:bluemix:public:service:global:::endpoint:test.private.example.com", DataType: "string"},
			{Name: "region", Value: options.Region, DataType: "string"},
		}

		err := options.RunSchematicTest()
		assert.Nil(t, err, "This should not have errored")
	}

	// Check if "DO_NOT_DESTROY_ON_FAILURE" is set
	envVal, _ := os.LookupEnv("DO_NOT_DESTROY_ON_FAILURE")
	// Destroy the temporary existing resources if required
	if t.Failed() && strings.ToLower(envVal) == "true" {
		fmt.Println("Terratest failed. Debug the test and delete resources manually.")
	} else {
		logger.Log(t, "START: Destroy (prereq resources)")
		terraform.Destroy(t, existingTerraformOptions)
		terraform.WorkspaceDelete(t, existingTerraformOptions, prefix)
		logger.Log(t, "END: Destroy (prereq resources)")
	}
}

func TestUpgradeVPEDA(t *testing.T) {
	t.Parallel()

	// ------------------------------------------------------------------------------------
	// Provision a catalog first
	// ------------------------------------------------------------------------------------

	prefix := fmt.Sprintf("cat_vpe_da_%s", strings.ToLower(random.UniqueId()))
	realTerraformDir := ".."
	tempTerraformDir, _ := files.CopyTerraformFolderToTemp(realTerraformDir, fmt.Sprintf(prefix+"-%s", strings.ToLower(random.UniqueId())))

	// Verify ibmcloud_api_key variable is set
	checkVariable := "TF_VAR_ibmcloud_api_key"
	val, present := os.LookupEnv(checkVariable)
	require.True(t, present, checkVariable+" environment variable not set")
	require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	logger.Log(t, "Tempdir: ", tempTerraformDir)
	tempDaDir := tempTerraformDir + "/" + catalogDAdir
	// Delete cache
	toDelete := []string{tempDaDir + "/.terraform", tempDaDir + "/.terraform.lock.hcl"}
	for _, s := range toDelete {
		err := os.RemoveAll(s)
		if err != nil {
			log.Printf("failed to remove %s: %v", s, err)
		}
	}
	existingTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempDaDir,
		Vars: map[string]interface{}{
			"existing_resource_group_name": resourceGroup,
			"label":                        prefix,
			"kind":                         "vpe",
		},
		// Set Upgrade to true to ensure latest version of providers and modules are used by terratest.
		// This is the same as setting the -upgrade=true flag with terraform.
		Upgrade: true,
	})

	terraform.WorkspaceSelectOrNew(t, existingTerraformOptions, prefix)
	_, existErr := terraform.InitAndApplyE(t, existingTerraformOptions)
	if existErr != nil {
		assert.True(t, existErr == nil, "Init and Apply of pre-req resources failed in TestVPEDA test")
	} else {
		// ------------------------------------------------------------------------------------
		// Deploy DA
		// ------------------------------------------------------------------------------------
		options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
			Testing: t,
			Region:  "us-south",
			Prefix:  prefix,
			TarIncludePatterns: []string{
				"*.tf",
				"modules/*/*.tf",
				vpeDADir + "/*.tf",
			},
			TemplateFolder:         vpeDADir,
			Tags:                   []string{"cm-vpe-da"},
			DeleteWorkspaceOnFail:  false,
			WaitJobCompleteMinutes: 60,
		})

		options.TerraformVars = []testschematic.TestSchematicTerraformVar{
			{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
			{Name: "catalog_id", Value: terraform.Output(t, existingTerraformOptions, "id"), DataType: "string"},
			{Name: "name", Value: prefix, DataType: "string"},
			{Name: "label", Value: prefix, DataType: "string"},
			{Name: "dns_domain", Value: "example.com", DataType: "string"},
			{Name: "service_crn", Value: "crn:v1:bluemix:public:service:global:::endpoint:test.private.example.com", DataType: "string"},
			{Name: "region", Value: options.Region, DataType: "string"},
		}

		err := options.RunSchematicUpgradeTest()
		if !options.UpgradeTestSkipped {
			assert.Nil(t, err, "This should not have errored")
		}
	}

	// Check if "DO_NOT_DESTROY_ON_FAILURE" is set
	envVal, _ := os.LookupEnv("DO_NOT_DESTROY_ON_FAILURE")
	// Destroy the temporary existing resources if required
	if t.Failed() && strings.ToLower(envVal) == "true" {
		fmt.Println("Terratest failed. Debug the test and delete resources manually.")
	} else {
		logger.Log(t, "START: Destroy (prereq resources)")
		terraform.Destroy(t, existingTerraformOptions)
		terraform.WorkspaceDelete(t, existingTerraformOptions, prefix)
		logger.Log(t, "END: Destroy (prereq resources)")
	}
}
