variable "name" {
  type        = string
  description = "The name of the namespace"
  validation {
    condition     = !endswith(var.name, "/")
    error_message = "Namespaces cannot end with /"
  }

  validation {
    condition     = !contains(["root", "sys", "audit", "auth", "cubbyhole", "identity"], var.name)
    error_message = "Namespaces cannot contain reserved strings."
  }
}

variable "tf_project_name" {
  type        = string
  description = "The name of the Terraform project to bind the JWT auth to. Workspace is inferred from name"
  default     = "SB Vault Lab"
}

variable "auth_mount_accessor" {
  type        = string
  description = "The accessor of the authentication mount for creating group aliases"
}
