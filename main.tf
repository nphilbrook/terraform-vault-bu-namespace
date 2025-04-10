resource "vault_namespace" "this" {
  path = var.name
}

# resource "vault_jwt_auth_backend" "jwt_hcp_tf" {
#   namespace          = vault_namespace.this.path
#   description        = "JWT auth backend for HCP Terraform"
#   path               = "jwt"
#   oidc_discovery_url = "https://app.terraform.io"
#   bound_issuer       = "https://app.terraform.io"
# }

# resource "vault_policy" "hcp_tf" {
#   namespace = vault_namespace.this.path
#   name      = "hcp-tf-management"
#   # ref management_tf_policy.tf
#   policy = data.vault_policy_document.management.hcl
# }

# This role will be used by the BU management workspace to manage the namespace
# Ref workspace variable setup: https://github.com/nphilbrook/hcp-tf-control/TBW
# resource "vault_jwt_auth_backend_role" "hcp_tf_bu" {
#   namespace = vault_namespace.this.path

#   backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
#   role_name      = "hcp-tf-management"
#   token_policies = ["default", vault_policy.hcp_tf.name]

#   bound_audiences = ["vault.workload.identity"]
#   bound_claims = {
#     sub = "organization:philbrook:project:${var.tf_project_name}:workspace:vault-${var.name}-terraform:run_phase:*"
#   }
#   bound_claims_type = "glob"
#   user_claim        = "terraform_project_id"
#   role_type         = "jwt"
# }

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

# TODO: Policies for these mounts
