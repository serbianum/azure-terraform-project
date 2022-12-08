output "application_public_address" {
  value = azurerm_public_ip.wp_public_ip.fqdn
}