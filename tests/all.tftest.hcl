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

run "no_prod_kv" {
  command = plan

  variables {
    kv_group_nonprod_name = "foobar"
  }
  assert {
    condition     = length(vault_identity_group_alias.kv_prod) == 0
    error_message = "prod kv group alias was created but not expected"
  }
}

run "yes_prod_kv" {
  command = plan

  variables {
    kv_group_prod_name = "foobar"
  }
  assert {
    condition     = length(vault_identity_group_alias.kv_prod) == 1
    error_message = "prod kv group alias was not created but expected"
  }
}

run "no_nonprod_kv" {
  command = plan

  assert {
    condition     = length(vault_identity_group_alias.kv_nonprod) == 0
    error_message = "nonprod kv group alias was created but not expected"
  }
}

run "yes_nonprod_kv" {
  command = plan

  variables {
    kv_group_nonprod_name = "foobar"
  }
  assert {
    condition     = length(vault_identity_group_alias.kv_nonprod) == 1
    error_message = "nonprod kv group alias was not created but expected"
  }
}
