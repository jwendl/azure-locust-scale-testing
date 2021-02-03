resource "azurerm_resource_group" "test_harness_rg" {
    name     = var.resource_group_name
    location = var.resource_group_location
}

module "network" {
    source                      = "./modules/network"
    virtual_network_name        = "${var.resource_prefix}vnet${var.resource_postfix}"
    resource_group_name         = azurerm_resource_group.test_harness_rg.name
    resource_group_location     = azurerm_resource_group.test_harness_rg.location
    network_subnet_name         = "${var.resource_prefix}sub${var.resource_postfix}"
    network_security_group_name = "${var.resource_prefix}nsg${var.resource_postfix}"
}

module "main-vm" {
    source                        = "./modules/main-vm"
    main_vm_name                  = "${var.resource_prefix}mvm${var.resource_postfix}"
    resource_group_name           = azurerm_resource_group.test_harness_rg.name
    resource_group_location       = azurerm_resource_group.test_harness_rg.location
    vm_public_ip_name             = "${var.resource_prefix}mvmpip${var.resource_postfix}"
    domain_name_label             = "${var.resource_prefix}mvm${var.resource_postfix}"
    virtual_network_main_nic_name = "${var.resource_prefix}mvmnic${var.resource_postfix}"
    subnet_id                     = module.network.subnet_id
    admin_username                = "jwendl"
}

module "agent-vm" {
    source                           = "./modules/agent-vm"
    agent_vm_prefix                  = "${var.resource_prefix}avm${var.resource_postfix}"
    resource_group_name              = azurerm_resource_group.test_harness_rg.name
    resource_group_location          = azurerm_resource_group.test_harness_rg.location
    vm_public_ip_name                = "${var.resource_prefix}avmpip${var.resource_postfix}"
    domain_name_label                = "${var.resource_prefix}avm${var.resource_postfix}"
    virtual_network_agent_nic_prefix = "${var.resource_prefix}avmnic${var.resource_postfix}"
    subnet_id                        = module.network.subnet_id
    admin_username                   = "jwendl"
}
