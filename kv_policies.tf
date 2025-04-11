data "vault_policy_document" "kv_nonprod_read" {
  rule {
    path         = "${vault_mount.kv_nonprod.path}/???"
    capabilities = ["read"]
    description  = "Read kv secrets from nonprod"
  }
}
