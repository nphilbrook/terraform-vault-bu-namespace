output "namespace_id" {
  description = "The internal ID Vault assigns this namespace."
  value       = vault_namespace.this.namespace_id
}

output "path" {
  description = "The path to the namespace."
  value       = vault_namespace.this.path
}
