# Mapa nazwa -> IP. W Fazie 2 wygenerujemy z tego inventory Ansible.
output "node_ips" {
  description = "Statyczne IP wezlow klastra (z konfiguracji cloud-init)"
  value       = { for k, m in module.k3s_nodes : k => m.ip_address }
}

# IP zaraportowane przez qemu-guest-agent (weryfikacja, ze agent dziala).
output "node_ips_reported" {
  description = "IP odczytane przez qemu-guest-agent po starcie"
  value       = { for k, m in module.k3s_nodes : k => m.ip_reported }
}
