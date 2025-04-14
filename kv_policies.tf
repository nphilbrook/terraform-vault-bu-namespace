data "vault_policy_document" "kv_nonprod" {
  rule {
    path         = "${vault_namespace.this.path}/${vault_mount.kv_nonprod.path}*"
    capabilities = ["create", "update", "patch", "read", "delete", "list"]
    description  = "manage kv secrets in nonprod"
  }
}

data "vault_policy_document" "kv_prod" {
  rule {
    path         = "${vault_namespace.this.path}/${vault_mount.kv_prod.path}*"
    capabilities = ["create", "update", "patch", "read", "delete", "list"]
    description  = "manage kv secrets in prod"
  }
}
