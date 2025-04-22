resource "vault_jwt_auth_backend" "jwt_gha" {
  count              = var.configure_gha ? 1 : 0
  namespace          = vault_namespace.this.path
  description        = "JWT auth backend for Github Actions"
  path               = "jwt-github"
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend_role" "gha_role" {
  count             = var.configure_gha ? 1 : 0
  namespace         = vault_namespace.this.path
  backend           = vault_jwt_auth_backend.jwt_gha[0].path
  role_name         = "gha-workflow"
  bound_audiences   = ["https://github.com/nphilbrook"]
  bound_claims_type = "glob"
  bound_claims = {
    sub                = "repo:nphilbrook/*"
    workflow           = "retrieve-vault"
    runner_environment = "self-hosted"
  }
  user_claim     = "sub"
  role_type      = "jwt"
  token_ttl      = 300
  token_type     = "service"
  token_policies = ["gha-policy"]
}

resource "vault_policy" "gha_policy" {
  count = var.configure_gha ? 1 : 0

  namespace = vault_namespace.this.path
  name      = "gha-policy"
  # ref below
  policy = data.vault_policy_document.gha_policy[0].hcl
}

data "vault_policy_document" "gha_policy" {
  count = var.configure_gha ? 1 : 0

  rule {
    path         = "prod/kv/*"
    capabilities = ["read"]
    description  = "Read prod kv secrets"
  }

  rule {
    path         = "nonprod/kv/*"
    capabilities = ["read"]
    description  = "Read nonprod kv secrets"
  }
}
