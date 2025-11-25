variable "name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "tags" {
  description = "Common tags for the resource group"
  type        = map(string)
  default     = {}
}
