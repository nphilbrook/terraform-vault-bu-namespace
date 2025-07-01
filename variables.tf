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
