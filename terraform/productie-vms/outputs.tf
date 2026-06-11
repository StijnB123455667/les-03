output "public_ips" {
  description = "Publieke IP-adressen van alle productie VM's."
  value = {
    for name, pip in azurerm_public_ip.main :
    name => pip.ip_address
  }
}

output "inventory_file" {
  description = "Pad naar automatisch gegenereerde Ansible inventory."
  value       = local_file.inventory.filename
}
