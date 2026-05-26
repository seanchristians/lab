output "token" {
  value       = terraform_data.desec_token.output
  description = "deSEC.io API token"
  sensitive   = true
}
