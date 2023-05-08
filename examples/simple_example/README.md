# Simple Example

This example illustrates how to use the `subnet` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_directories | List of paths to folders where routes configs are stored in yaml format. Folder may include subfolders with configuration files. Files suffix must be `.yaml`. | `list(string)` | n/a | yes |
| network | The name of the network to deploy to | `any` | n/a | yes |
| project\_id | The project ID to deploy to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_subnet | Subnet with specified network. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
