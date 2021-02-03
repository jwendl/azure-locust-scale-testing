resource "azurerm_virtual_network" "test_harness_vnet" {
    name                = var.virtual_network_name
    address_space       = ["192.168.0.0/16"]
    resource_group_name = var.resource_group_name
    location            = var.resource_group_location
}

resource "azurerm_subnet" "test_harness_subnet" {
    name                 = var.network_subnet_name
    resource_group_name  = azurerm_virtual_network.test_harness_vnet.resource_group_name
    virtual_network_name = azurerm_virtual_network.test_harness_vnet.name
    address_prefixes     = [ "192.168.1.0/24" ]
}

resource "azurerm_network_security_group" "test_harness_nsg" {
    name                = var.network_security_group_name
    resource_group_name = azurerm_virtual_network.test_harness_vnet.resource_group_name
    location            = azurerm_virtual_network.test_harness_vnet.location
}

resource "azurerm_network_security_rule" "test_harness_nsg_rule_1" {
    name                       = "ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_virtual_network.test_harness_vnet.resource_group_name
    network_security_group_name = azurerm_network_security_group.test_harness_nsg.name
}

resource "azurerm_network_security_rule" "test_harness_nsg_rule_2" {
    name                       = "http"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8089"
    destination_port_range     = "8089"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_virtual_network.test_harness_vnet.resource_group_name
    network_security_group_name = azurerm_network_security_group.test_harness_nsg.name
}
