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

# variable "tf_project_name" {
#   type        = string
#   description = "The name of the Terraform project to bind the JWT auth to. Workspace is inferred from name"
#   default     = "SB Vault Lab"
# }

variable "auth_mount_accessor" {
  type        = string
  description = "The accessor of the authentication mount for creating group aliases"
}

variable "configure_aws" {
  type        = bool
  default     = false
  description = "whether to cerate an AWS dynamic secrets mount or not"
}


variable "initial_aws_access_key_id" {
  type        = string
  default     = null
  description = "Initial access key ID to configure AWS dynamic auth. Should be rotated via Vault API after creation."
  validation {
    condition     = var.configure_aws ? var.initial_aws_access_key_id != null : true
    error_message = "initial_aws_access_key_id must be set if configure_awm is true"
  }
}

variable "initial_aws_secret_access_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Initial secret access key to configure AWS dynamic auth. Should be rotated via Vault API after creation."
  validation {
    condition     = var.configure_aws ? var.initial_aws_secret_access_key != null : true
    error_message = "initial_aws_secret_access_key must be set if configure_awm is true"
  }
}
