provider "vault" {
  address = "unused"
}

variables {
  auth_mount_accessor = "auth_saml_1234abcde"
  name                = "foobar"
}

run "aws_fail_without_creds" {
  command = plan

  variables {
    configure_aws = true
  }

  expect_failures = [
    var.initial_aws_access_key_id,
    var.initial_aws_secret_access_key
  ]
}

run "aws_false_success" {
  command = plan

  variables {
    configure_aws = false
  }

  assert {
    condition     = length(vault_aws_secret_backend.aws) == 0
    error_message = "AWS Secret Backend created when not expected"
  }
}

run "aws_true_success" {
  command = plan

  variables {
    configure_aws                 = true
    initial_aws_access_key_id     = "AKIAXQY5RIOOOOOO"
    initial_aws_secret_access_key = "aoeu1234"
  }
  assert {
    condition     = length(vault_aws_secret_backend.aws) == 1
    error_message = "AWS Secret Backend not created when expected"
  }
}
