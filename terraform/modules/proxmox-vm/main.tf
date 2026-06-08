resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  node_name = var.proxmox_node
  vm_id     = var.vm_id
  tags      = var.tags

  # Pelny klon szablonu cloud-init (VMID 9000).
  clone {
    vm_id = var.template_id
    full  = true
  }

  # qemu-guest-agent jest wstrzykniety do szablonu (virt-customize) -
  # dzieki temu Terraform odczyta IP i poprawnie zatrzyma maszyne.
  agent {
    enabled = true
  }
  stop_on_destroy = true

  cpu {
    cores = var.cores
    type  = "host" # pelne przekazanie cech CPU; OK przy braku migracji w homelabie
  }

  # RAM "dedicated" bez "floating" = brak ballooningu (stabilna pamiec dla kubelet).
  memory {
    dedicated = var.memory
  }

  # Klonowany dysk powieksza sie do docelowego rozmiaru; growpart w cloud-init
  # rozszerzy partycje root przy pierwszym starcie.
  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = var.disk_size
    discard      = "on"
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.ip_cidr
        gateway = var.gateway
      }
    }

    dns {
      servers = var.dns_servers
    }

    user_account {
      username = var.ci_user
      keys     = [trimspace(var.ssh_public_key)]
    }
  }

  network_device {
    bridge = var.network_bridge
  }

  operating_system {
    type = "l26" # Linux 2.6+ / nowoczesne kernele
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account, # cloud-init aplikuje sie tylko raz przy starcie
    ]
  }
}
