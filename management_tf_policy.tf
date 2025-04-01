data "vault_policy_document" "management" {


  # ======= AWS secrets engine setup =========
  rule {
    path         = "sys/mounts/aws"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount"
  }

  rule {
    path         = "aws/config/root"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount config"
  }

  rule {
    path         = "aws/roles*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS roles"
  }

  rule {
    path         = "sys/policies/acl/aws-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for dynamic AWS credentials (prefix by convention)"
  }

  rule {
    path         = "auth/jwt/role/hcp-tf*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage JWT auth for TF roles"
  }
  # ======= End AWS secrets engine setup =========
}
