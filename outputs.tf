output "namespace_id" {
  description = "The internal ID Vault assigns this namespace."
  value       = vault_namespace.this.namespace_id
}

output "path" {
  description = "The path to the namespace."
  value       = vault_namespace.this.path
}

output "id" {
  description = "The full path to the namespace, which the Vault provider calls `id` for some reason."
  value       = vault_namespace.this.id
}

output "namespace_admin_policy_name" {
  description = "The name of the namespace admin policy."
  value       = vault_policy.namespace_admin.name
}
