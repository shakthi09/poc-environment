resource "azurerm_resource_group" "confluent" {
  name     = var.name
  location = var.location
  tags     = var.tags
}