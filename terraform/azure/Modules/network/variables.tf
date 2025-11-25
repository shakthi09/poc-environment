variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.10.0.0/20"]
}

variable "pe_subnet_cidr" {
  type        = string
  default     = "10.10.1.0/24"
}

variable "app_subnet_cidr" {
  type        = string
  default     = "10.10.2.0/24"
}

variable "private_link_service_alias" {
  type        = string
  description = "Confluent PrivateLink service alias for this region"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS zone name, e.g. centralus.azure.private.confluent.cloud"
}

variable "tags" {
  type    = map(string)
  default = {}
}