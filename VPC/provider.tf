provider "azurerm"{
    features {}
}

resource "random_string" "fqdn" {
 length  = 6
 special = false
 upper   = false
 number  = false
}