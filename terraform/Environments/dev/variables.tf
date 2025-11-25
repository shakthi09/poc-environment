# Confluent auth
variable "confluent_cloud_api_key" {
  type        = string
  description = "Confluent Cloud API key"
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  type        = string
  description = "Confluent Cloud API secret"
  sensitive   = true
}

# Azure
variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "location" {
  type        = string
  description = "Azure location / Confluent region"
  default     = "centralus"
}

variable "rg_name" {
  type        = string
  default     = "rg-confluent-poc-dev"
}

variable "vnet_name" {
  type        = string
  default     = "vnet-confluent-poc-dev"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS zone for Confluent"
  default     = "centralus.azure.private.confluent.cloud"
}

variable "tags" {
  type    = map(string)
  default = {
    project = "confluent-poc"
    env     = "dev"
  }
}

variable "confluent_env_name" {
  type        = string
  default     = "poc-env-dev"
}

variable "confluent_network_name" {
  type        = string
  default     = "poc-env-dev-azure-pl"
}

variable "confluent_cluster_name" {
  type        = string
  default     = "poc-cluster-dev"
}
