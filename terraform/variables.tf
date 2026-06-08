variable "proxmox_endpoint" {
  description = "URL API Proxmoxa, np. https://192.168.1.10:8006/"
  type        = string
}

variable "proxmox_api_token" {
  description = "Token API w formacie 'user@realm!tokenid=UUID'"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Pomin weryfikacje TLS (self-signed cert w homelabie)"
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Nazwa wezla Proxmox, na ktorym ladują maszyny (zobacz: pvecm nodes / nazwa w GUI)"
  type        = string
}

variable "template_id" {
  description = "VMID szablonu cloud-init do klonowania"
  type        = number
  default     = 9000
}

variable "datastore_id" {
  description = "Storage dla dyskow VM (lvm-thin), np. local-lvm"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Mostek sieciowy, np. vmbr0"
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "Brama domyslna sieci LAN"
  type        = string
}

variable "dns_servers" {
  description = "Lista serwerow DNS dla VM"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "ci_user" {
  description = "Uzytkownik tworzony przez cloud-init na kazdej VM"
  type        = string
  default     = "debian"
}

variable "ssh_public_key" {
  description = "Publiczny klucz SSH wstrzykiwany do kazdej VM"
  type        = string
}

# Pojedyncze zrodlo prawdy o klastrze. Dodanie/zmiana noda = edycja tej mapy.
variable "vms" {
  description = "Definicje maszyn wirtualnych klastra K3s"
  type = map(object({
    vm_id     = number
    cores     = number
    memory    = number # MB
    disk_size = number # GB
    ip_cidr   = string # np. "192.168.1.110/24"
    role      = string # "master" | "worker"
  }))
}
