variable "main_vm_name" {
    description = "The main virtual machine name"
}

variable "resource_group_name" {
    description = "The resource group name"
}

variable "resource_group_location" {
    description = "The resource group location"
}

variable "vm_public_ip_name" {
    description = "The vm's public ip address resource name"
}

variable "domain_name_label" {
    description = "The main vm domain name label"
}

variable "virtual_network_main_nic_name" {
    description = "The main vm virtual nic name"
}

variable "subnet_id" {
    description = "The subnet azure resource id"
}

variable "vm_size" {
    description = "The size of the virtual machine"
    default     = "Standard_DS4_v2"
}

variable "admin_username" {
    description = "The admin username"
}
