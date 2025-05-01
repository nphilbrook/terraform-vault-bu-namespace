resource "vault_namespace" "this" {
  path = var.name
}

resource "vault_jwt_auth_backend" "jwt_hcp_tf" {
  namespace          = vault_namespace.this.path
  description        = "JWT auth backend for HCP Terraform"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}
