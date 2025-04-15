# Default k/v mounts
resource "vault_mount" "kv_nonprod" {
  namespace = vault_namespace.this.path
  path      = "nonprod/kv"
  type      = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "nonprod K/V secrets"
}

resource "vault_mount" "kv_prod" {
  namespace = vault_namespace.this.path
  path      = "prod/kv"
  type      = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "prod K/V secrets"
}

resource "vault_policy" "kv_nonprod" {
  name = "kv-nonprod"
  # ref kv_policies.tf
  policy = data.vault_policy_document.kv_nonprod.hcl
}

resource "vault_policy" "kv_prod" {
  name = "kv-prod"
  # ref kv_policies.tf
  policy = data.vault_policy_document.kv_prod.hcl
}

# External group for nonprod
resource "vault_identity_group" "kv_nonprod" {
  name     = "${vault_namespace.this.path}-kv_nonprod"
  type     = "external"
  policies = [vault_policy.kv_nonprod.name]
}

resource "vault_identity_group_alias" "kv_nonprod" {
  name           = "sg_${vault_namespace.this.path}_appdev_nonprod"
  mount_accessor = var.auth_mount_accessor
  canonical_id   = vault_identity_group.kv_nonprod.id
}

# External group for prod
resource "vault_identity_group" "kv_prod" {
  name     = "${vault_namespace.this.path}-kv_prod"
  type     = "external"
  policies = [vault_policy.kv_nonprod.name, vault_policy.kv_prod.name]
}

resource "vault_identity_group_alias" "kv_prod" {
  name           = "sg_${vault_namespace.this.path}_appdev_prod"
  mount_accessor = var.auth_mount_accessor
  canonical_id   = vault_identity_group.kv_prod.id
}
