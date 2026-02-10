output "fqdn" {
  value       = "${var.subdomain}.${local.domain}"
  description = "Fully-qualified domain name of the device"
}
