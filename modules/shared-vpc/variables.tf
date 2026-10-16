variable "project_id" {
  description = "Google Cloud project ID that will own the Shared VPC."
  type        = string
}

variable "network_name" {
  description = "Name of the Shared VPC network."
  type        = string
}

variable "region" {
  description = "Region in which the initial application subnet will be created."
  type        = string
}

variable "subnet_name" {
  description = "Name of the initial application subnet."
  type        = string
}

variable "subnet_cidr" {
  description = "IPv4 CIDR range for the initial application subnet."
  type        = string
}

variable "private_google_access" {
  description = "Whether Private Google Access is enabled on the subnet."
  type        = bool
  default     = true
}
