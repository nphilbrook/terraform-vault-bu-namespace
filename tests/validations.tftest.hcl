provider "vault" {
  address = "unused"
}

variables {
  auth_mount_accessor = "auth_saml_1234abcde"
  name                = "foobar"
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
