resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "db_app_nw" {
  count               = 1
  name                = "db_app_nw-${format("%00.0f", count.index)}-${substr(azurerm_resource_group.rg.name,11,14)}"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "db_sbnt" {
  count                = 1
  name                 = "db_sbnt-${format("%00.0f", count.index)}-${substr(azurerm_resource_group.rg.name,11,14)}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.db_app_nw[count.index].name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "app_sbnt" {
  count                = 1
  name                 = "app_sbnt-${format("%00.0f", count.index)}-${substr(azurerm_resource_group.rg.name,11,14)}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.db_app_nw[count.index].name}"
  address_prefix       = "10.0.1.0/24"
}
