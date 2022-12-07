#Creating virtual netwok to the current resource group
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers
}

#Creating the subnets
 resource "azurerm_subnet" "subnet" {
   resource_group_name  = azurerm_resource_group.terraform.name
   virtual_network_name = azurerm_virtual_network.vnet.name
   name                 = var.subnet_name
   address_prefixes     = var.subnet_ip_range
   depends_on           = [azurerm_virtual_network.vnet]
   
 }

 resource "azurerm_public_ip" "wordpress" {
  name                = "wordpress-public-ip"
  location            = var.region
  resource_group_name = azurerm_resource_group.terraform.name
  allocation_method   = "Static"
  domain_name_label   = random_string.fqdn.result
}
