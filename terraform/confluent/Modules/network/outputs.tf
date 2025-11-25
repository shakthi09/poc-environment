output "id" {
  value = confluent_network.confluent.id
}

output "private_link_service_alias" {
  value = confluent_network.confluent.azure[0].private_link_service_alias
}
