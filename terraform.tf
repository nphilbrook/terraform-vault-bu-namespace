terraform {
  required_version = ">=1.11"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~>4.7.0"
    }
  }
}
