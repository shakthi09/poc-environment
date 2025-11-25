 
# Confluent Environment
 

module "confluent_environment" {
  source           = "../../confluent/Modules/environment"
  environment_name = var.confluent_env_name
}

# Confluent Network


module "confluent_network" {
  source              = "../../confluent/Modules/network"
  environment_id      = module.confluent_environment.id
  display_name        = var.confluent_network_name
  cloud               = "AZURE"
  region              = var.location
  azure_subscription_id = var.azure_subscription_id
}


# Azure Resource Group


module "rg" {
  source   = "../../azure/Modules/resourcegroup"
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}


# Azure Networking 

module "azure_network" {
  source                   = "../../azure/Modules/network"
  resource_group_name      = module.rg.name
  location                 = module.rg.location
  vnet_name                = var.vnet_name
  address_space            = ["10.10.0.0/20"]
  pe_subnet_cidr           = "10.10.1.0/24"
  app_subnet_cidr          = "10.10.2.0/24"
  private_link_service_alias = module.confluent_network.private_link_service_alias
  private_dns_zone_name    = var.private_dns_zone_name
  tags                     = var.tags
}

# Confluent Cluster

module "confluent_cluster" {
  source        = "../../confluent/Modules/cluster"
  environment_id = module.confluent_environment.id
  network_id    = module.confluent_network.id
  cluster_name  = var.confluent_cluster_name
  cloud         = "AZURE"
  region        = var.location
  availability  = "SINGLE_ZONE"
  topics        = ["orders", "payments"]
}