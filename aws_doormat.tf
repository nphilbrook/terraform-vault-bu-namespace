data "aws_iam_policy" "demo_user_permissions_boundary" {
  count = var.configure_aws ? 1 : 0
  name  = "DemoUser"
}

data "aws_iam_role" "vault_target_iam_role" {
  count = var.configure_aws ? 1 : 0
  name  = "vault-assumed-role-credentials-demo"
}

resource "aws_iam_user" "vault_mount_user" {
  count                = var.configure_aws ? 1 : 0
  name                 = "vault-root-${replace(vault_namespace.this.id, "/", "-")}"
  permissions_boundary = data.aws_iam_policy.demo_user_permissions_boundary[0].arn
  force_destroy        = true
}

data "aws_iam_policy_document" "vault_mount_user_policy" {
  count = var.configure_aws ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      data.aws_iam_role.vault_target_iam_role[0].arn
    ]
  }
}

resource "aws_iam_policy" "vault_mount_user_policy" {
  count  = var.configure_aws ? 1 : 0
  name   = "vault-mount-user"
  policy = data.aws_iam_policy_document.vault_mount_user_policy[0].json
}

resource "aws_iam_user_policy_attachment" "vault_mount_user" {
  count      = var.configure_aws ? 1 : 0
  user       = aws_iam_user.vault_mount_user[0].name
  policy_arn = aws_iam_policy.vault_mount_user_policy[0].arn
}

resource "aws_iam_access_key" "vault_mount_user" {
  count = var.configure_aws ? 1 : 0
  user  = aws_iam_user.vault_mount_user[0].name
  lifecycle {
    ignore_changes = all
  }
}

resource "vault_aws_secret_backend" "aws_doormat" {
  count = var.configure_aws ? 1 : 0

  path       = "aws-doormat"
  namespace  = vault_namespace.this.path
  access_key = aws_iam_access_key.vault_mount_user[0].id
  secret_key = aws_iam_access_key.vault_mount_user[0].secret
  lifecycle {
    ignore_changes = [
      access_key,
      secret_key
    ]
  }
}

resource "vault_aws_secret_backend_role" "vault_aws_role_doormat" {
  count = var.configure_aws ? 1 : 0

  namespace       = vault_namespace.this.path
  backend         = vault_aws_secret_backend.aws_doormat[0].path
  name            = "aws-dynamic"
  credential_type = "assumed_role"
  role_arns       = [data.aws_iam_role.vault_target_iam_role[0].arn]
}
