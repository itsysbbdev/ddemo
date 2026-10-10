output "firefox_app_url" {
  value = "https://${module.firefox_app.app_service_default_hostname}"
}
