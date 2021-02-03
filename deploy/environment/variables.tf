variable "resource_group_name" {
    description = "The resource group name"
}

variable "resource_group_location" {
    description = "The resource group location"
}

variable "resource_prefix" {
    description = "The resource prefix"
}

variable "resource_postfix" {
    description = "The resource postfix"
}

variable "sku_name" {
    description = "The SKU for the app service plan"
    default     = "Standard"
}

variable "keyvault_sku_name" {
    description = "The SKU for keyvault"
    default     = "standard"
}
