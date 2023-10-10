output "resource_group_name" {
  value = azurerm_resource_group.Azuredevops.name
}

output "public_ip_addresses" {
  value = [for vm in azurerm_linux_virtual_machine.main : vm.public_ip_address]
}

output "ip_configuration_name" {
  value = [for idx in range(var.vm_number) : azurerm_network_interface.main[idx].ip_configuration[0].name]
}
