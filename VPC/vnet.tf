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

 resource "azurerm_public_ip" "wp_public_ip" {
  name                = "wordpress-public-ip"
  location            = var.region
  resource_group_name = azurerm_resource_group.terraform.name
  allocation_method   = "Static"
  domain_name_label   = random_string.fqdn.result
}



# resource "azurerm_network_interface" "ss_vm_nic" {
#   depends_on=[azurerm_resource_group.terraform]
#   name                = "SS Network Interface"
#   location            = azurerm_resource_group.terraform.location
#   resource_group_name = azurerm_resource_group.terraform.name
  
#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.wp_public_ip.id
#   }
# }
