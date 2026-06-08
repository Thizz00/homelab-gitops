variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "cores" {
  type = number
}

variable "memory" {
  description = "RAM w MB (dedykowane, bez ballooningu)"
  type        = number
}

variable "disk_size" {
  description = "Rozmiar dysku w GB"
  type        = number
}

variable "ip_cidr" {
  description = "Adres IP z maska, np. 192.168.1.110/24"
  type        = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "proxmox_node" {
  type = string
}

variable "template_id" {
  type = number
}

variable "datastore_id" {
  type = string
}

variable "network_bridge" {
  type = string
}

variable "gateway" {
  type = string
}

variable "dns_servers" {
  type = list(string)
}

variable "ci_user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
