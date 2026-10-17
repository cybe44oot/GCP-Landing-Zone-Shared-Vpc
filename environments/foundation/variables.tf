variable "org_id" {
  description = "Google Cloud organization ID."
  type        = string
}

variable "billing_account_id" {
  description = "Open billing account to link to the lab projects."
  type        = string
}

variable "folder_name" {
  description = "Name of the dedicated landing zone lab folder."
  type        = string
  default     = "landing-zone-lab"
}

variable "host_project_id" {
  description = "Globally unique project ID for the Shared VPC host."
  type        = string

  validation {
    condition = (
      length(var.host_project_id) >= 6 &&
      length(var.host_project_id) <= 30 &&
      can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.host_project_id))
    )
    error_message = "Use a 6-30 character project ID with lowercase letters, digits, and hyphens. It must start with a letter and end with a letter or digit."
  }
}

variable "workload_project_id" {
  description = "Globally unique project ID for the workload service project."
  type        = string

  validation {
    condition = (
      length(var.workload_project_id) >= 6 &&
      length(var.workload_project_id) <= 30 &&
      can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.workload_project_id))
    )
    error_message = "Use a 6-30 character project ID with lowercase letters, digits, and hyphens. It must start with a letter and end with a letter or digit."
  }
}
