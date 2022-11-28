#Creating Azure resource group
resource "azurerm_resource_group" "terraform" {
  name     = "TFProject-resources"
  location = "West Europe"
}

#Creating security group and addid to existing terraform resource group
resource "azurerm_network_security_group" "terraform" {
  name                = "terraform-security-group"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
}

resource "azurerm_network_security_rule" "terraform" {
  name                        = "HTTP"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = [80, 443]
  destination_port_range      = [80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terrafrom.name
  network_security_group_name = azurerm_network_security_group.terraform.name
}

resource "azurerm_network_security_rule" "terraform" {
  name                        = "HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = [80, 443]
  destination_port_range      = [80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terrafrom.name
  network_security_group_name = azurerm_network_security_group.terraform.name
}

#Creating virtual netwok to the current resource group
resource "azurerm_virtual_network" "terraform" {
  name                = "tfp-network"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.terraform.id
  }

  sbunet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.terraform.id
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.terraform.id
  }

  tags = {
    environment = "VNET"
  }
}

