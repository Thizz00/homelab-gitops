# Jedno wywolanie modulu na kazda maszyne z mapy var.vms.
# DRY: caly opis 3 maszyn sprowadza sie do jednej petli for_each.
module "k3s_nodes" {
  source   = "./modules/proxmox-vm"
  for_each = var.vms

  vm_name   = each.key
  vm_id     = each.value.vm_id
  cores     = each.value.cores
  memory    = each.value.memory
  disk_size = each.value.disk_size
  ip_cidr   = each.value.ip_cidr
  tags      = ["terraform", "k3s", each.value.role]

  proxmox_node   = var.proxmox_node
  template_id    = var.template_id
  datastore_id   = var.datastore_id
  network_bridge = var.network_bridge
  gateway        = var.gateway
  dns_servers    = var.dns_servers
  ci_user        = var.ci_user
  ssh_public_key = var.ssh_public_key
}
