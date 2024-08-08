output "webapp_url" {
  value = azurerm_linux_web_app.cbwa.default_hostname
}

output "webapp_ips" {
  value = azurerm_linux_web_app.cbwa.outbound_ip_addresses
}