output "public_ip" {
  description = "Az OpenVPN NVA statikus publikus IP címe"
  value       = module.compute.public_ip_address
}

output "ssh_command" {
  description = "SSH parancs a virtuális gép eléréséhez"
  value       = "ssh azureuser@${module.compute.public_ip_address}"
}

output "download_ovpn_command" {
  description = "SCP parancs a client1.ovpn profil letöltéséhez"
  value       = "scp azureuser@${module.compute.public_ip_address}:/home/azureuser/client1.ovpn ./client1.ovpn"
}
