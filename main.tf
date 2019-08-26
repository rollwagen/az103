
# Configure the Microsoft Azure Provider
provider "azurerm" {
    # subscription_id = ""

}

###########################################################
# Network "id" assigned by instructor = '4' 
###########################################################

variable "vnet1" {
    default = {
        location = "westeurope"
	name = "VNET-AZEUW-0001-DEV"
        resource_group = "RG-AZEUW-NETWORK-0001-DEV"
	address_space = "10.4.0.0/16"
	dmz_subnet_name = "dmz"
	dmz_subnet_range = "10.4.2.0/24"
	dmz_network_security_group = "NSG-AZEUW-VNET-0001-dmz-DEV"
	intern_subnet_name = "intern"
	intern_subnet_range = "10.4.1.0/24"
	intern_network_security_group = "NSG-AZEUW-VNET-0001-intern-DEV"
    }
}

variable "vnet2" {
    default = {
        location = "eastus"
	name = "VNET-AZEU1-0001-DEV"
        resource_group = "RG-AZUE1-NETWORK-0001-DEV"
	address_space = "10.104.0.0/16"
	dmz_subnet_name = "dmz"
	dmz_subnet_range = "10.104.2.0/24"
	dmz_network_security_group = "NSG-AZEU1-VNET-0001-dmz-DEV"
	intern_subnet_name = "intern"
	intern_subnet_range = "10.104.1.0/24"
	intern_network_security_group = "NSG-AZEU1-VNET-0001-intern-DEV"
    }
}

###########################################################
# END (variables section)
###########################################################

#
# Creating Europe....
#
resource "azurerm_resource_group" "vnet1_rg" {
  name     = "${var.vnet1.resource_group}"
  location = "${var.vnet1.location}"
}

resource "azurerm_virtual_network" "vnet1_vnet" {
  name                = "${var.vnet1.name}"
  resource_group_name = "${azurerm_resource_group.vnet1_rg.name}" # see https://github.com/terraform-providers/terraform-provider-azurerm/issues/532
  location            = "${var.vnet1.location}"
  address_space       = ["${var.vnet1.address_space}"]
}

resource "azurerm_subnet" "vnet1_dmz" {
  name                 = "${var.vnet1.dmz_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.vnet1_rg.name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet1_vnet.name}"
  address_prefix       = "${var.vnet1.dmz_subnet_range}"
}

resource "azurerm_subnet" "vnet1_intern" {
  name                 = "${var.vnet1.intern_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.vnet1_rg.name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet1_vnet.name}"
  address_prefix       = "${var.vnet1.intern_subnet_range}"
}

resource "azurerm_network_security_group" "vnet1_dmz_nsg" {
  name                = "${var.vnet1.dmz_network_security_group}"
  location            = "${var.vnet1.location}"
  resource_group_name  = "${azurerm_resource_group.vnet1_rg.name}" 
}

resource "azurerm_network_security_group" "vnet1_intern_nsg" {
  name                = "${var.vnet1.intern_network_security_group}"
  location            = "${var.vnet1.location}"
  resource_group_name  = "${azurerm_resource_group.vnet1_rg.name}" 
}

#
# Creating US....
#
resource "azurerm_resource_group" "vnet2_rg" {
  name     = "${var.vnet2.resource_group}"
  location = "${var.vnet2.location}"
}

resource "azurerm_virtual_network" "vnet2_vnet" {
  name                = "${var.vnet2.name}"
  resource_group_name = "${azurerm_resource_group.vnet2_rg.name}" 
  location            = "${var.vnet2.location}"
  address_space       = ["${var.vnet2.address_space}"]
}

resource "azurerm_subnet" "vnet2_dmz" {
  name                 = "${var.vnet2.dmz_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.vnet2_rg.name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet2_vnet.name}"
  address_prefix       = "${var.vnet2.dmz_subnet_range}"
}

resource "azurerm_subnet" "vnet2_intern" {
  name                 = "${var.vnet2.intern_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.vnet2_rg.name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet2_vnet.name}"
  address_prefix       = "${var.vnet2.intern_subnet_range}"
}

resource "azurerm_network_security_group" "vnet2_dmz_nsg" {
  name                = "${var.vnet2.dmz_network_security_group}"
  location            = "${var.vnet2.location}"
  resource_group_name  = "${azurerm_resource_group.vnet2_rg.name}" 
}

resource "azurerm_network_security_group" "vnet2_intern_nsg" {
  name                = "${var.vnet2.intern_network_security_group}"
  location            = "${var.vnet2.location}"
  resource_group_name  = "${azurerm_resource_group.vnet2_rg.name}" 
}

