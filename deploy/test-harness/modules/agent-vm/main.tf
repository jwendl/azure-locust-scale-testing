resource "azurerm_public_ip" "test_harness_agent_public_ip" {
    name                = "${var.vm_public_ip_name}-${count.index}"
    resource_group_name = var.resource_group_name
    location            = var.resource_group_location
    allocation_method   = "Static"
    domain_name_label   = "${var.agent_vm_prefix}-${count.index}"
    count               = 10
}

resource "azurerm_network_interface" "test_harness_agent_nic" {
    name                = "${var.virtual_network_agent_nic_prefix}-${count.index}"
    resource_group_name = azurerm_public_ip.test_harness_agent_public_ip[count.index].resource_group_name
    location            = azurerm_public_ip.test_harness_agent_public_ip[count.index].location
    count               = 10

    ip_configuration {
        name                          = "internal"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.test_harness_agent_public_ip[count.index].id
    }
}

resource "azurerm_linux_virtual_machine" "test_harness_agent" {
    name                          = "${var.agent_vm_prefix}-${count.index}"
    resource_group_name           = azurerm_public_ip.test_harness_agent_public_ip[count.index].resource_group_name
    location                      = azurerm_public_ip.test_harness_agent_public_ip[count.index].location
    size                          = var.vm_size
    admin_username                = "jwendl"
    count                         = 10
    network_interface_ids = [
        azurerm_network_interface.test_harness_agent_nic[count.index].id,
    ]

    admin_ssh_key {
        username   = "jwendl"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}
