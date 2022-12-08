#Creating Linux VM Scale set
# resource "azurerm_linux_virtual_machine_scale_set" "vmss" { 
#   depends_on=[azurerm_network_interface.ss_vm_nic]
#   name                = "vmss"
#   resource_group_name = azurerm_resource_group.terraform.name
#   location            = azurerm_resource_group.terraform.location
#   sku                 = "Standard_D2S_v3"
#   instances           = 1
#   admin_username      = "adminuser"
#   custom_data = filebase64("customdata.tpl")

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = var.public_key
#   }

#   source_image_reference {
#     publisher = "OpenLogic"
#     offer     = "CentOS"
#     sku       = "7_9-gen2"
#     version   = "latest"
#   }

#    network_interface {
#     name                = "wordpress-nic"
#     primary             = true

#     ip_configuration {
      
#       name                  = "ip-config"
#       primary               = true
#       subnet_id             = azurerm_subnet.subnet.id #here we pull the subnet id through that "for_each"
#       public_ip_address_id  = azurerm_public_ip.wp_public_ip.id
#     }
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }

# }
 


resource "azurerm_lb" "example" {
  name                = "test"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.wp_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id     = azurerm_lb.example.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  resource_group_name            = azurerm_resource_group.terraform.name
}

resource "azurerm_lb_probe" "example" {
  loadbalancer_id     = azurerm_lb.example.id
  name                = "http-probe"
  protocol            = "Http"
  request_path        = "/health"
  port                = 8080
}

resource "azurerm_virtual_machine_scale_set" "example" {
  name                = "mytestscaleset-1"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.example.id

  sku {
    name     = "Standard_D2S_v3"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "myadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/myadmin/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }

}