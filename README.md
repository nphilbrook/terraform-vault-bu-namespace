## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.6 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >=4.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_aws_secret_backend.aws](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend_role.vault_aws_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_identity_group.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group.read](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group_alias.alias](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_identity_group_alias.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_identity_group_alias.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_jwt_auth_backend.jwt_gha](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend.jwt_hcp_tf](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.gha_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.vault_jwt_aws_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_mount.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_namespace.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) | resource |
| [vault_policy.aws_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.gha_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy_document.aws_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.gha_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.kv_nonprod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.kv_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_mount_accessor"></a> [auth\_mount\_accessor](#input\_auth\_mount\_accessor) | The accessor of the authentication mount for creating group aliases | `string` | n/a | yes |
| <a name="input_configure_aws"></a> [configure\_aws](#input\_configure\_aws) | whether to cerate an AWS dynamic secrets mount or not | `bool` | `false` | no |
| <a name="input_configure_gha"></a> [configure\_gha](#input\_configure\_gha) | whether to cerate JWT roles and policies for GHA | `bool` | `false` | no |
| <a name="input_gha_org"></a> [gha\_org](#input\_gha\_org) | A Github Org to use in your GHA JWT auth for binding audience and claims. Required if configure\_gha is true. | `string` | `null` | no |
| <a name="input_initial_aws_access_key_id"></a> [initial\_aws\_access\_key\_id](#input\_initial\_aws\_access\_key\_id) | Initial access key ID to configure AWS dynamic auth. Should be rotated via Vault API after creation. | `string` | `null` | no |
| <a name="input_initial_aws_secret_access_key"></a> [initial\_aws\_secret\_access\_key](#input\_initial\_aws\_secret\_access\_key) | Initial secret access key to configure AWS dynamic auth. Should be rotated via Vault API after creation. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the namespace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The internal ID Vault assigns this namespace. |
