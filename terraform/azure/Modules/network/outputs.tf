output "vnet_id" {
  value = azurerm_virtual_network.confluent.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.confluent.id
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.confluent.name
}
