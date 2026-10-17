variable "project_id" {
  description = "Google Cloud project ID that will own the Shared VPC."
  type        = string

  validation {
    condition     = length(var.project_id) > 5 && length(var.project_id) <= 30
    error_message = "project_id must be a valid-length Google Cloud project ID."
  }
}

variable "network_name" {
  description = "Name of the Shared VPC network."
  type        = string
}

variable "region" {
  description = "Region in which the application subnet will be created."
  type        = string
}

variable "subnet_name" {
  description = "Name of the application subnet."
  type        = string
}

variable "subnet_cidr" {
  description = "IPv4 CIDR range for the application subnet."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.subnet_cidr))
    error_message = "subnet_cidr must be a valid IPv4 CIDR range."
  }
}

variable "private_google_access" {
  description = "Whether Private Google Access is enabled on the subnet."
  type        = bool
  default     = true
}
