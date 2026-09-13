# terraform-gcp-gke

Creates a small zonal GKE Standard cluster with one Spot node pool, bounded autoscaling, Workload Identity, and shielded nodes.

## Usage

Use the released module from a composition:

```sh
module "gke" {
  source     = "github.com/defdevio/terraform-gcp-gke?ref=v0.1.0"
  project_id = var.project_id
  network    = module.network.network_name
  subnetwork = module.network.subnetwork_name
}
```

`create_resources = false` is for credential-free validation. Consumers accept zonal Spot interruption.

## Testing

The plan-only Terratest suite in `test` initializes and plans the module with OpenTofu. It does not create cloud resources or require provider credentials:

```sh
cd test
go test ./...
```

Pull requests run both the OpenTofu validation workflow and the Terratest workflow automatically.

## Releases

Releases are created automatically from conventional commits merged into `main`:

- `feat:` creates a minor release
- `fix:` creates a patch release
- `feat!:` or `fix!:` creates a major release
- `chore:` does not create a release

Install `pre-commit` and `terraform-docs`, then enable the repository hooks:

```sh
pre-commit install
pre-commit run --all-files
```

## Layout

- `versions.tf`: OpenTofu/Terraform version and provider constraints
- `variables.tf`: the consumer API
- `main.tf`: module implementation
- `outputs.tf`: stable consumer outputs
- `test/module_test.go`: plan-only Terratest coverage
- `.github/workflows/`: pull-request validation, Terratest, and release automation

## Module Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.46.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.spot](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.node_container_pull](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.node](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | Optional Google access token for authenticated operations. | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the GKE cluster. | `string` | `"opendepot-demo"` | no |
| <a name="input_create_resources"></a> [create\_resources](#input\_create\_resources) | Whether to create the GKE cluster and node resources. Set false for credential-free validation. | `bool` | `true` | no |
| <a name="input_network"></a> [network](#input\_network) | VPC network name or self-link for the cluster. | `string` | n/a | yes |
| <a name="input_node_machine_type"></a> [node\_machine\_type](#input\_node\_machine\_type) | Compute Engine machine type for GKE nodes. | `string` | `"e2-standard-2"` | no |
| <a name="input_node_service_account_id"></a> [node\_service\_account\_id](#input\_node\_service\_account\_id) | Account ID for the dedicated Google service account used by GKE nodes. | `string` | `"opendepot-gke-nodes"` | no |
| <a name="input_pods_range_name"></a> [pods\_range\_name](#input\_pods\_range\_name) | Name of the existing secondary range used for GKE pods. | `string` | `"gke-pods"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Cloud project for the GKE cluster. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Google Cloud region used by the provider. | `string` | `"us-central1"` | no |
| <a name="input_services_range_name"></a> [services\_range\_name](#input\_services\_range\_name) | Name of the existing secondary range used for GKE services. | `string` | `"gke-services"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Subnet name or self-link for the cluster. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zonal location for the GKE cluster and node pool. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Cluster endpoint. |
| <a name="output_cluster_location"></a> [cluster\_location](#output\_cluster\_location) | Cluster zone. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | GKE cluster name. |
| <a name="output_node_pool_name"></a> [node\_pool\_name](#output\_node\_pool\_name) | Spot node pool name. |
| <a name="output_node_service_account_email"></a> [node\_service\_account\_email](#output\_node\_service\_account\_email) | Dedicated Google service account used by GKE nodes. |
| <a name="output_node_service_account_id"></a> [node\_service\_account\_id](#output\_node\_service\_account\_id) | Account ID for the dedicated Google service account used by GKE nodes. |
<!-- END_TF_DOCS -->

The section between `BEGIN_TF_DOCS` and `END_TF_DOCS` is generated by `terraform-docs` and must not be edited manually.

## Contribution guidance

See [CONTRIBUTING.md](CONTRIBUTING.md) for local tools, the placeholder replacement map, testing, and commit conventions.
