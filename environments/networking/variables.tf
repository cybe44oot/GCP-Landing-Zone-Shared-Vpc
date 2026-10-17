variable "project_id" {
  description = "Project ID for the Shared VPC host project."
  type        = string
}

variable "region" {
  description = "Primary region for the initial network subnet."
  type        = string
  default     = "me-central2"
}

variable "network_name" {
  description = "Name of the Shared VPC network."
  type        = string
  default     = "alz-shared-vpc"
}

variable "subnet_name" {
  description = "Name of the initial application subnet."
  type        = string
  default     = "alz-me-central2-app-01"
}

variable "subnet_cidr" {
  description = "Non-overlapping IPv4 CIDR for the initial application subnet."
  type        = string
}

variable "workload_project_id" {
  description = "Workload Project ID that use the Shared VPC."
  type        = string
}
