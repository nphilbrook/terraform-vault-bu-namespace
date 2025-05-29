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

variable "kv_group_prod_name" {
  type        = string
  description = "Name of the group to use for production k/v access"
  default     = null
}

variable "kv_group_nonprod_name" {
  type        = string
  description = "Name of the group to use for nonprod k/v access"
  default     = null
}

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
    error_message = "initial_aws_access_key_id must be set if configure_aws is true"
  }
}

variable "initial_aws_secret_access_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Initial secret access key to configure AWS dynamic auth. Should be rotated via Vault API after creation."
  validation {
    condition     = var.configure_aws ? var.initial_aws_secret_access_key != null : true
    error_message = "initial_aws_secret_access_key must be set if configure_aws is true"
  }
}

# variable "configure_gha" {
#   type        = bool
#   default     = false
#   description = "whether to cerate JWT roles and policies for GHA"
# }

# variable "gha_org" {
#   type        = string
#   description = "A Github Org to use in your GHA JWT auth for binding audience and claims. Required if configure_gha is true."
#   default     = null
#   validation {
#     condition     = var.configure_gha ? var.gha_org != null : true
#     error_message = "gha_org must be set if configure_gha is true"
#   }
# }
