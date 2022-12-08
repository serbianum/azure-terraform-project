output "public_ip"{
    value = module.azurerm_network_interface.nic.ip
}