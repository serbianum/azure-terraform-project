# Create MySQL Server
resource "azurerm_mysql_server" "my_sql" {
  resource_group_name = azurerm_resource_group.terraform.name
  name                ="team2sql-whynot2"                                         #"team2sql-${(random_string.fqdn.result)}"
  location            = azurerm_resource_group.terraform.location
  version             = "5.7"

  administrator_login          = var.database_admin_login
  administrator_login_password = var.database_admin_password

  sku_name                     = "GP_Gen5_4"
  storage_mb                   = "102400"
  auto_grow_enabled            = false
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  #ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Create MySql DataBase
resource "azurerm_mysql_database" "my_db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.terraform.name
  server_name         = azurerm_mysql_server.my_sql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "firewall_rule" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.terraform.name
  server_name         = azurerm_mysql_server.my_sql.name
  start_ip_address    = azurerm_public_ip.public_ip.ip_address
  end_ip_address      = azurerm_public_ip.public_ip.ip_address
}

data "azurerm_mysql_server" "wordpress" {
  name                = azurerm_mysql_server.my_sql.name
  resource_group_name = azurerm_resource_group.terraform.name
}