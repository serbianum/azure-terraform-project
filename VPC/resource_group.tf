#Creating Azure resource group
resource "azurerm_resource_group" "terraform" {
  name     = var.res_group
  location = var.region
}

resource "random_string" "random_s" {
  length  = 6
  special = false
  upper   = false
  number  = false
}






 
