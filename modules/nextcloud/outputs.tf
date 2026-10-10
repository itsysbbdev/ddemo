output "nc_url" {
  description = "The public URL of the Nextcloud Container App"
  value       = "https://${azurerm_container_app.nc_nextcloud_container.ingress[0].fqdn}"
}
