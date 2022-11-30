#Creating Azure resource group
resource "azurerm_resource_group" "terraform" {
  name     = var.res_group
  location = var.region
}

#Creating security group and addid to existing terraform resource group
resource "azurerm_network_security_group" "terraform" {
  name                = var.sec_group
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
}

module "network-security-group" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.terraform.name
  location              = var.region
  security_group_name   = var.sec_group
  source_address_prefix = [var.subnet1,var.subnet2, var.subnet3]
  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    },
    {
      name              = "LDAP"
      source_port_range = "1024-1026"
    }
  ]

  custom_rules = [
    {
      name                   = "http"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "80"
      source_address_prefix  = [var.subnet1,var.subnet2, var.subnet3]
      description            = "Open port 80 for HTTP traffic"
    },
    {
      name                    = "https"
      priority                = 200
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "tcp"
      source_port_range       = "*"
      destination_port_range  = "443"
      source_address_prefixes = [var.subnet1,var.subnet2, var.subnet3]
      description             = "Open port 443 for HTTPS traffic"
    },
  ]

  tags = {
    environment = "dev"
  }

  depends_on = [azurerm_resource_group.terraform]
}

#THIS IS COMMENTED BECAUSE IT ALLOWS ONLY ONE RULE AT A TIME, EXAMPLE ABOVE LOOKS LIKE A MORE SUITABLE METHOD
# resource "azurerm_network_security_rule" "terraform" {
#   name                        = "HTTP"
#   priority                    = 100
#   direction                   = "INBOUND"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.terraform.name
#   network_security_group_name = azurerm_network_security_group.terraform.name
# }


#Creating virtual netwok to the current resource group
resource "azurerm_virtual_network" "terraform" {
  name                = var.vnet_name
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers

  subnet {
    name           = "subnet1"
    address_prefix = var.subnet1
    security_group = azurerm_network_security_group.terraform.id
  }

  subnet {
    name           = "subnet2"
    address_prefix = var.subnet2
    security_group = azurerm_network_security_group.terraform.id
  }

  subnet {
    name           = "subnet3"
    address_prefix = var.subnet3
    security_group = azurerm_network_security_group.terraform.id
  }

  tags = {
    environment = "dev"
  }
}

