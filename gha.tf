resource "vault_jwt_auth_backend_role" "gha_role" {
  count             = var.configure_gha ? 1 : 0
  namespace         = vault_namespace.this.path
  backend           = vault_jwt_auth_backend.jwt_hcp_tf.path
  role_name         = "auth.jwt.app1.workflow1"
  bound_audiences   = ["https://github.com/nphilbrook"]
  bound_claims_type = "string"
  bound_subject     = "repo:nphilbrook/lambda-code-fib:ref:refs/heads/main"
  bound_claims = {
    actor                 = "nphilbrook"
    workflow              = "demo-jwt-auth-workflow"
    repository_visibility = "private"
    runner_environment    = "self-hosted"
    repository_owner      = "nphilbrook"
  }
  user_claim     = "sub"
  role_type      = "jwt"
  token_ttl      = 300
  token_type     = "service"
  token_policies = ["app1-workflow1"]
}
