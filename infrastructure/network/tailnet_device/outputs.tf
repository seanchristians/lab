output "fqdn" {
  value       = porkbun_dns_record.this.content
  description = "Fully-qualified domain name of the device"
}
