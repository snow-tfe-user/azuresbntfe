resource "random_id" "server" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "aztferg-${random_id.server.hex}"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "nw" {
  name                = "network-${random_id.server.hex}"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "sbnt" {
  name                 = "subnet-${random_id.server.hex}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.nw.name}"
  address_prefix       = "10.0.2.0/24"
}
