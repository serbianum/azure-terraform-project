output "application_public_address" {
  value = azurerm_public_ip.public_ip.random_s
}