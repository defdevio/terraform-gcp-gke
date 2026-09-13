package test

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestModulePlan(t *testing.T) {
	terraformDir := test_structure.CopyTerraformFolderToTemp(t, "..", ".")

	options := &terraform.Options{
		TerraformBinary: "tofu",
		TerraformDir:    terraformDir,
		PlanFilePath:    filepath.Join(t.TempDir(), "terraform-module.tfplan"),
		Vars:            map[string]interface{}{"project_id": "opendepot-demo", "network": "demo", "subnetwork": "demo", "create_resources": false},
	}

	terraform.InitAndPlan(t, options)
	plan := terraform.ShowWithStruct(t, options)

	assert.Empty(t, plan.ResourceChangesMap)
	assert.Equal(t, "opendepot-gke-nodes", plan.RawPlan.OutputChanges["node_service_account_id"].After)
}
