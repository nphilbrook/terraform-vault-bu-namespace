# terraform-vault-bu-namespace
This is a module for creating a Business Unit namespace on HashiCorp Vault. It is intended to be called from the `hcp-vault-admin-terraform` repository, and created namespaces
will live under either the `testing` or `live` namespace, depending on which workspace was used to create it (`hcp-vault-admin-terraform-testing` or `hcp-vault-admin-terraform-live`).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.6 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >=4.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | >=4.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_identity_group.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group_alias.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_identity_group_alias.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_mount.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_namespace.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) | resource |
| [vault_policy.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.namespace_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy_document.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.namespace_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_mount_accessor"></a> [auth\_mount\_accessor](#input\_auth\_mount\_accessor) | The accessor of the authentication mount for creating group aliases | `string` | n/a | yes |
| <a name="input_kv_group_nonprod_name"></a> [kv\_group\_nonprod\_name](#input\_kv\_group\_nonprod\_name) | Name of the group to use for nonprod k/v access | `string` | `null` | no |
| <a name="input_kv_group_prod_name"></a> [kv\_group\_prod\_name](#input\_kv\_group\_prod\_name) | Name of the group to use for production k/v access | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the namespace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The full path to the namespace, which the Vault provider calls `id` for some reason. |
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The internal ID Vault assigns this namespace. |
| <a name="output_path"></a> [path](#output\_path) | The path to the namespace. |
<!-- END_TF_DOCS -->
