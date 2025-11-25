variable "environment_id" {
  type        = string
  description = "Confluent environment ID"
}

variable "network_id" {
  type        = string
  description = "Confluent network ID"
}

variable "cluster_name" {
  type        = string
  description = "Kafka cluster display name"
}

variable "cloud" {
  type        = string
  default     = "AZURE"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "availability" {
  type        = string
  default     = "SINGLE_ZONE"
}

variable "topics" {
  type        = list(string)
  default     = ["orders", "payments"]
}

variable "service_account_name" {
  type        = string
  default     = "poc-app-sa"
}

variable "service_account_description" {
  type        = string
  default     = "Service account for POC application"
}
