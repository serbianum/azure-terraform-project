#Creating Azure resource group
resource "azurerm_resource_group" "terraform" {
  name     = var.res_group
  location = var.region
}

#Creating security group and addid to existing terraform resource group
resource "azurerm_network_security_group" "nsg" {
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
  network_security_group_name = azurerm_network_security_group.nsg.name
}


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
   for_each             = var.subnets
   resource_group_name  = azurerm_resource_group.terraform.name
   virtual_network_name = azurerm_virtual_network.vnet.name
   name                 = each.value["name"]
   address_prefixes     = each.value["address_prefixes"]
   depends_on           = [azurerm_virtual_network.vnet]
   
 }

resource "azurerm_public_ip" "public_ip" {
  name                = "wordpress-public-ip"
  location            = var.region
  resource_group_name = azurerm_resource_group.terraform.name
  allocation_method   = "Static"
  domain_name_label   = random_string.random_string.result
}

resource "random_string" "random_string" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

#Assigning a security group to all existing subnets
resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


#Creating Linux VM Scale set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  for_each            = var.subnets #this will loop through all declared subnets
  name                = "vmss"
  resource_group_name = azurerm_resource_group.terraform.name
  location            = azurerm_resource_group.terraform.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
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
    name    = azurerm_virtual_network.vnet.name 
    primary = true


   ip_configuration {
      
      name      = "terraform"
      primary   = true
      subnet_id = azurerm_subnet.subnet[each.key].id #here we pull the subnet id through that "for_each"
    }
  }
}
 
resource "azurerm_lb" "wp_lb" {
  name                = "wordpress-lb"
  location            = var.region
  resource_group_name = azurerm_resource_group.terraform.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.wp_lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "wordpress" {
  #resource_group_name = azurerm_resource_group.terraform.name
  loadbalancer_id     = azurerm_lb.wp_lb.id
  name                = "ssh-running-probe"
  port                = 80
}

resource "azurerm_lb_rule" "lbnatrule" {
  #resource_group_name            = azurerm_resource_group.terraform.name
  loadbalancer_id                = azurerm_lb.wp_lb.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bpepool.id]
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.wordpress.id
}