resource "azurerm_virtual_network" "confluent" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "pe" {
  name                 = "${var.vnet_name}-pe-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.confluent.name
  address_prefixes     = [var.pe_subnet_cidr]
}

resource "azurerm_subnet" "app" {
  name                 = "${var.vnet_name}-app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.confluent.name
  address_prefixes     = [var.app_subnet_cidr]
}

resource "azurerm_private_endpoint" "confluent" {
  name                = "${var.vnet_name}-confluent-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name = "${var.vnet_name}-confluent-pl-conn"
    private_connection_resource_id = var.private_link_service_alias
    is_manual_connection           = true
    subresource_names              = ["bootstrap"]
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone" "confluent" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.vnet_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.confluent.name
  virtual_network_id    = azurerm_virtual_network.confluent.id
}

resource "azurerm_private_dns_a_record" "wildcard" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.confluent.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records = [
    azurerm_private_endpoint.confluent.private_service_connection[0].private_ip_address
  ]
}