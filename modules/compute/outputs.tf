output "public_ip_address" {
  description = "The public IP address of the Virtual Machine"
  value       = azurerm_public_ip.pip.ip_address
}

output "private_key_pem" {
  description = "Private key to access the VM"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}
