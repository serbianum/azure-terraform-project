data "azurerm_public_ip" "ss_ip" {
  name                = "name_of_public_ip"
  resource_group_name = "name_of_resource_group"
}

output "domain_name_label" {
  value = "${data.azurerm_public_ip.ss_ip.domain_name_label}"
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.ss_ip.ip_address}"
}