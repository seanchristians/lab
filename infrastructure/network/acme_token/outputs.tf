output "token" {
  value       = restapi_object.desec_token.create_response.token
  description = "deSEC.io API token"
  ephemeral   = true
}

output "fqdn" {
  value       = "${var.subdomain}.${var.domain}"
  description = "Fully-qualified domain name for this network device."
}
