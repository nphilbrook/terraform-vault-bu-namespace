# These policies exist to facilitate visibility into many parts of the system for namespace admins
# It is intentionally read-only so that write ops go through Terraform code
data "vault_policy_document" "namespace_admin" {
  rule {
    path         = "${vault_namespace.this.path}/sys/policies/acl*"
    capabilities = ["read", "list"]
    description  = "Read ACL policies"
  }

  rule {
    path         = "${vault_namespace.this.path}/auth*"
    capabilities = ["read", "list"]
    description  = "Read/list auth methods broadly across Vault"
  }

  rule {
    path         = "${vault_namespace.this.path}/sys/auth*"
    capabilities = ["read", "list"]
    description  = "List auth methods"
  }

  rule {
    path         = "${vault_namespace.this.path}/identity*"
    capabilities = ["read", "list"]
    description  = "Read identity objects"
  }

  rule {
    path         = "${vault_namespace.this.path}/sys/mounts*"
    capabilities = ["read", "list"]
    description  = "Read/list secrets engines"
  }

  rule {
    path         = "${vault_namespace.this.path}/sys/config/ui"
    capabilities = ["read", "list"]
    description  = "Configure Vault UI"
  }

  rule {
    path         = "${vault_namespace.this.path}/sys/leases*"
    capabilities = ["read", "list"]
    description  = "Read/list leases"
  }

  rule {
    path         = "${vault_namespace.this.path}/sys/plugins*"
    capabilities = ["read", "list"]
    description  = "Read/list plugins, if any"
  }

}

resource "vault_policy" "namespace_admin" {
  name      = "${vault_namespace.this.path}-namespace-admin"
  policy    = data.vault_policy_document.namespace_admin.hcl
}
