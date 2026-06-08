output "ip_address" {
  description = "Statyczny IP z konfiguracji cloud-init (bez maski)"
  value       = split("/", var.ip_cidr)[0]
}

output "ip_reported" {
  description = "Pierwszy nielokalny IPv4 zaraportowany przez qemu-guest-agent"
  value       = try(proxmox_virtual_environment_vm.this.ipv4_addresses[1][0], "n/a")
}

output "vm_id" {
  value = proxmox_virtual_environment_vm.this.vm_id
}
