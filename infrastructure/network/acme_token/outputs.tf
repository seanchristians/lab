output "token" {
  value       = restapi_object.desec_token.api_data.token
  description = "deSEC.io API token"
  ephemeral   = true
}

output "fqdn" {
  value       = "${var.subdomain}.${var.domain}"
  description = "Fully-qualified domain name for this network device."
}

output "last_updated" {
  value       = restapi_object.desec_token.api_data.created
  description = "Last time the token was created"
}
