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

#Open port 80 not sure this is how we supposed to do it
resource "azurerm_network_security_rule" "terraform" {
  name                        = "HTTP"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terraform.name
  network_security_group_name = azurerm_network_security_group.terraform.name
}


#Creating virtual netwok to the current resource group
resource "azurerm_virtual_network" "terraform" {
  name                = var.vnet_name
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers
}
 resource "azurerm_subnet" "terraform" {
   for_each             = var.subnets
   resource_group_name  = azurerm_resource_group.terraform.name
   virtual_network_name = azurerm_virtual_network.terraform.name
   security_group        = azurerm_network_security_group.id
   name                 = each.value["name"]
   address_prefixes     = each.value["address_prefixes"]
   depends_on           = [azurerm_virtual_network.terraform]
   
 }
  
 resource "azurerm_linux_virtual_machine_scale_set" "terraform" {
  name                = "terraform-vmss"
  resource_group_name = azurerm_resource_group.terraform.name
  location            = azurerm_resource_group.terraform.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDU7DWDdaSk8VxH29TJhmF1j2gd+h0USTboymQdRBUsc7xVgjZumWznghwxs3AmajcsZuigCP0Jkh+qJ545hWBtv2Y7uhynJ/mbpmNjyP/gXKPYW8igkyrMOkOsyBQBfqr2di5IOTojc0xHlLcUcalosc4RwL4K8wEQvcd+aD1Stqa0uG6JV/vAYDGb8XY6BS10MrRb+uPmZDM5J3AwiYkDsiI1qbFHfuMibUST4zAkCU5hy+/2ZHN4mPXREKBL4U7rER+iN4hG9RTaIrjJYkm3meByZepFaZEEayx39A831EPpKMep8amWOWWjAZO7ipieDu+5tOecy2+d6XgKCjvH9qY/WtphWTW1sf3cIidA69/I0JqG/XemvpZBY+liicSuVy6mvWUlY2HbHt+7mKxzHf3IzYNNdtvkfFvj6bNxHvH/d75HDw+awiNSRgKvti5vYp30OdkKy4LX/zbuAXqivSvIE4jkdL4xWwAL8yjzfGCwBD4OtI8w8TV4VwLshFc= mihai@cc-6faa9033-6857b67664-z87lb"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "terraform"
    primary = true

    ip_configuration {
      name      = "terraform"
      primary   = true
      subnet_id = azurerm_subnet.terraform.id
    }
  }
}
 


