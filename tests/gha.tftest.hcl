# provider "vault" {
#   address = "unused"
# }

# mock_provider "aws" {
#   mock_data "aws_iam_policy" {
#     defaults = {
#       arn = "arn:aws:iam::123456780000:policy/DemoUser"
#     }
#   }
# }

# variables {
#   auth_mount_accessor = "auth_saml_1234abcde"
#   name                = "foobar"
# }

# run "gha_fail_without_org" {
#   command = plan

#   variables {
#     configure_gha = true
#   }

#   expect_failures = [
#     var.gha_org
#   ]
# }

# run "gha_false_success" {
#   command = plan

#   variables {
#     configure_gha = false
#   }

#   assert {
#     condition     = length(vault_jwt_auth_backend.jwt_gha) == 0
#     error_message = "GHA JWT Backend created when not expected"
#   }
# }

# run "gha_true_success" {
#   command = plan

#   variables {
#     configure_gha = true
#     gha_org       = "foobar"
#   }
#   assert {
#     condition     = length(vault_jwt_auth_backend.jwt_gha) == 1
#     error_message = "GHA JWT Backend not created when expected"
#   }
# }
