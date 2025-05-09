resource "vault_aws_secret_backend" "aws" {
  count = var.configure_aws ? 1 : 0

  namespace  = vault_namespace.this.path
  access_key = var.initial_aws_access_key_id
  secret_key = var.initial_aws_secret_access_key
  lifecycle {
    ignore_changes = [
      access_key,
      secret_key
    ]
  }
}

resource "vault_aws_secret_backend_role" "vault_aws_role" {
  count = var.configure_aws ? 1 : 0

  namespace       = vault_namespace.this.path
  backend         = vault_aws_secret_backend.aws[0].path
  name            = "aws-dynamic"
  credential_type = "assumed_role"
  role_arns       = ["arn:aws:iam::517068637116:role/dyn-ec2-access", "arn:aws:iam::517068637116:role/s3-full-access"]
}

resource "vault_jwt_auth_backend_role" "vault_jwt_aws_role" {
  count = var.configure_aws ? 1 : 0

  namespace      = vault_namespace.this.path
  backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
  role_name      = "aws-dynamic"
  token_policies = ["default", vault_policy.aws_policy[0].name]

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    sub = "organization:philbrook:project:SB Vault Lab:workspace:aws-probable-pancake:run_phase:*"
  }
  bound_claims_type = "glob"
  user_claim        = "terraform_full_workspace"
  role_type         = "jwt"
}

resource "vault_policy" "aws_policy" {
  count = var.configure_aws ? 1 : 0

  namespace = vault_namespace.this.path
  name      = "aws-dynamic"
  # ref below
  policy = data.vault_policy_document.aws_policy[0].hcl
}

data "vault_policy_document" "aws_policy" {
  count = var.configure_aws ? 1 : 0

  rule {
    path         = "aws/creds/${vault_aws_secret_backend_role.vault_aws_role[0].name}"
    capabilities = ["read"]
    description  = "Read dynamic AWS credentials for the specified role"
  }

  rule {
    path         = "aws/sts/${vault_aws_secret_backend_role.vault_aws_role[0].name}"
    capabilities = ["read", "update", "create"]
    description  = "Read dynamic AWS credentials for the specified role with the STS path."
  }

  rule {
    path         = "aws-doormat/creds/${vault_aws_secret_backend_role.vault_aws_role[0].name}"
    capabilities = ["read"]
    description  = "Read dynamic AWS credentials for the specified role"
  }

  rule {
    path         = "aws-doormat/sts/${vault_aws_secret_backend_role.vault_aws_role[0].name}"
    capabilities = ["read", "update", "create"]
    description  = "Read dynamic AWS credentials for the specified role with the STS path."
  }
}
