variable "subscription_id" {
  description = "A cél Azure Subscription ID"
  type        = string
  default     = "dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4"
}

variable "tenant_id" {
  description = "A cél Azure Entra ID Tenant ID"
  type        = string
  default     = "2e6b6dee-5e65-44fb-82c5-be06ba1f8b3a"
}

variable "location" {
  description = "Azure régió a Full-Tunnel VPN infrastruktúrához"
  type        = string
  default     = "austriaeast"
}

variable "resource_group_name" {
  description = "A meglévő Resource Group neve"
  type        = string
  default     = "fulltunvpn"
}

variable "vnet_cidr" {
  description = "A VPN VNet címtartománya"
  type        = string
  default     = "10.20.0.0/16"
}

variable "subnet_cidr" {
  description = "A VPN Gateway alhálózat címtartománya"
  type        = string
  default     = "10.20.1.0/24"
}

variable "vm_private_ip" {
  description = "Az OpenVPN NVA fix belső IP címe"
  type        = string
  default     = "10.20.1.4"
}

variable "vpn_client_cidr" {
  description = "Az OpenVPN tun0 csatorna belső címtartománya"
  type        = string
  default     = "10.8.0.0/24"
}

variable "vm_size" {
  description = "Az OpenVPN NVA virtuális gép mérete"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Linux adminisztrátor felhasználónév"
  type        = string
  default     = "azureuser"
}

variable "openvpn_port" {
  description = "OpenVPN UDP port"
  type        = number
  default     = 1194
}

variable "tags" {
  description = "Egységes Azure erőforrás címkék"
  type        = map(string)
  default = {
    Project     = "fulltunvpn"
    ManagedBy   = "Terraform"
    Environment = "Production"
    Role        = "OpenVPN-FullTunnel-NVA"
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "prefix" {
  type    = string
  default = "fulltunvpn"
}
