resource "vault_identity_group" "read" {
  name     = "${var.name}-Read"
  type     = "external"
  policies = ["Cloud-Operations-Read"]
}

resource "vault_identity_group_alias" "alias" {
  name           = "${var.name}-Read"
  mount_accessor = var.auth_mount_accessor
  canonical_id   = vault_identity_group.read.id
}
