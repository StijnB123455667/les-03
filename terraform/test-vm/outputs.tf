output "vm_public_ip" {
  description = "Publiek IP-adres van de test VM."
  value       = azurerm_public_ip.main.ip_address
}

output "inventory_file" {
  description = "Pad naar automatisch gegenereerde Ansible inventory."
  value       = local_file.inventory.filename
}
