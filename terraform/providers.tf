terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.100"
    }
  }
}
provider "proxmox" {
  endpoint  = var.proxmox_endpoint  # np. "https://192.168.1.10:8006/"
  api_token = var.proxmox_api_token # format: "terraform@pve!provider=<UUID>"
  insecure  = var.proxmox_insecure  # true dla self-signed certa w homelabie
}
