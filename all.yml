locals {
  webservers = {
    for name, vm in var.vms : name => vm
    if vm.role == "webserver"
  }

  databases = {
    for name, vm in var.vms : name => vm
    if vm.role == "database"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${var.name_prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name_prefix}-vnet"
  address_space       = ["10.31.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "${var.name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.31.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.name_prefix}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ssh_source
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "main" {
  for_each            = var.vms
  name                = "${var.name_prefix}-${each.key}-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "main" {
  for_each            = var.vms
  name                = "${var.name_prefix}-${each.key}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.31.1.${each.value.private_ip_suffix}"
    public_ip_address_id          = azurerm_public_ip.main[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  for_each                  = var.vms
  network_interface_id      = azurerm_network_interface.main[each.key].id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_linux_virtual_machine" "main" {
  for_each            = var.vms
  name                = "${var.name_prefix}-${each.key}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.main[each.key].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

resource "local_file" "inventory" {
  filename = "${path.module}/../../generated/productie-inventory.ini"

  content = templatefile("${path.module}/inventory.tpl", {
    admin_username = var.admin_username
    webservers = {
      for name in keys(local.webservers) :
      name => azurerm_public_ip.main[name].ip_address
    }
    databases = {
      for name in keys(local.databases) :
      name => azurerm_public_ip.main[name].ip_address
    }
  })
}
