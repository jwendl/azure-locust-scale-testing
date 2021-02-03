resource "azurerm_public_ip" "test_harness_main_public_ip" {
    name                = var.vm_public_ip_name
    resource_group_name = var.resource_group_name
    location            = var.resource_group_location
    allocation_method   = "Static"
    domain_name_label   = var.domain_name_label
}

resource "azurerm_network_interface" "test_harness_main_nic" {
    name                = var.virtual_network_main_nic_name
    resource_group_name = azurerm_public_ip.test_harness_main_public_ip.resource_group_name
    location            = azurerm_public_ip.test_harness_main_public_ip.location

    ip_configuration {
        name                          = "internal"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.test_harness_main_public_ip.id
    }
}

resource "azurerm_linux_virtual_machine" "test_harness_main" {
    name                          = var.main_vm_name
    resource_group_name           = azurerm_public_ip.test_harness_main_public_ip.resource_group_name
    location                      = azurerm_public_ip.test_harness_main_public_ip.location
    size                          = var.vm_size
    admin_username                = var.admin_username
    
    network_interface_ids = [
        azurerm_network_interface.test_harness_main_nic.id,
    ]

    admin_ssh_key {
        username   = var.admin_username
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
