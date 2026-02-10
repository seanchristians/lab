output "fqdn" {
  value       = porkbun_dns_record.ipv4.content
  description = "Fully-qualified domain name of the device"
}
