variable "environment_id" {
  type        = string
  description = "Confluent environment ID"
}

variable "display_name" {
  type        = string
  description = "Network name"
}

variable "cloud" {
  type        = string
  description = "Cloud provider"
  default     = "AZURE"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID "
}