#Creating Linux VM Scale set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" { 
  depends_on=[azurerm_network_interface.ss_vm_nic]
  name                = "vmss"
  network_interface_ids = [azurerm_network_interface.ss_vm_nic.id]
  resource_group_name = azurerm_resource_group.terraform.name
  location            = azurerm_resource_group.terraform.location
  sku                 = "Standard_D2S_v3"
  instances           = 1
  admin_username      = "adminuser"
  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}
 