# These policies exist to facilitate visibility into many parts of the system for namespace admins
# It is intentionally read-only so that write ops go through Terraform code
data "vault_policy_document" "namespace_admin" {
  rule {
    path         = "sys/policies/acl*"
    capabilities = ["read", "list"]
    description  = "Read ACL policies"
  }

  rule {
    path         = "auth*"
    capabilities = ["read", "list"]
    description  = "Read/list auth methods broadly across Vault"
  }

  rule {
    path         = "sys/auth*"
    capabilities = ["read", "list"]
    description  = "List auth methods"
  }

  rule {
    path         = "identity*"
    capabilities = ["read", "list"]
    description  = "Read identity objects"
  }

  rule {
    path         = "sys/mounts*"
    capabilities = ["read", "list"]
    description  = "Read/list secrets engines"
  }

  rule {
    path         = "sys/config/ui"
    capabilities = ["read", "list"]
    description  = "Configure Vault UI"
  }

  rule {
    path         = "sys/leases*"
    capabilities = ["read", "list"]
    description  = "Read/list leases"
  }

  rule {
    path         = "sys/plugins*"
    capabilities = ["read", "list"]
    description  = "Read/list plugins, if any"
  }

}

resource "vault_policy" "namespace_admin" {
  namespace = vault_namespace.this.path
  name      = "namespace-admin"
  policy    = data.vault_policy_document.namespace_admin.hcl
}

# External group for ns admins
resource "vault_identity_group" "ns_admin" {
  name     = "${vault_namespace.this.path}-ns_admin"
  type     = "external"
  policies = [vault_policy.namespace_admin.name]
}

resource "vault_identity_group_alias" "ns_admin" {
  count          = var.namespace_admin_group_name != null ? 1 : 0
  name           = var.namespace_admin_group_name
  mount_accessor = var.auth_mount_accessor
  canonical_id   = vault_identity_group.ns_admin.id
}
