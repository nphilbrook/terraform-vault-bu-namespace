variables {
  auth_mount_accessor = "auth_saml_1234abcde"
  name = "foobar"
}

provider "vault" {
  address = "unused"
}

run "no_ending_slash" {
  command = plan

  variables {
    name = "foobar/"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved1" {
  command = plan

  variables {
    name = "root"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved2" {
  command = plan

  variables {
    name = "sys"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved3" {
  command = plan

  variables {
    name = "audit"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved4" {
  command = plan

  variables {
    name = "auth"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved5" {
  command = plan

  variables {
    name = "cubbyhole"
  }

  expect_failures = [
    var.name
  ]
}

run "no_reserved6" {
  command = plan

  variables {
    name = "identity"
  }

  expect_failures = [
    var.name
  ]
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
}

run "aws_true_success" {
  command = plan

  variables {
    configure_aws = true
    initial_aws_access_key_id = "AKIAXQY5RIOOOOOO"
    initial_aws_secret_access_key = "aoeu1234"
  }
}
