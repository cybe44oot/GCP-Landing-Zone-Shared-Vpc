provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "host_compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false  # tells Terraform not to disable the API merely because this Terraform resource is destroyed
}

resource "google_project_service" "workload_compute" {
  project            = var.workload_project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project_id

  depends_on = [
    google_project_service.host_compute
  ]
}

module "shared_vpc" {
  source = "../../modules/shared-vpc"

  project_id            = var.project_id
  network_name          = var.network_name
  region                = var.region
  subnet_name           = var.subnet_name
  subnet_cidr           = var.subnet_cidr
  private_google_access = true

  depends_on = [
    google_project_service.host_compute
  ]
}

resource "google_compute_shared_vpc_service_project" "workload" {
  host_project    = google_compute_shared_vpc_host_project.host.project   #here we attach the workload project to the host's Shared VPC
  service_project = var.workload_project_id

  depends_on = [
    google_project_service.workload_compute,
    module.shared_vpc
  ]
}

output "network_self_link" {
  description = "Shared VPC network self link."
  value       = module.shared_vpc.network_self_link
}

output "subnet_self_link" {
  description = "Application subnet self link."
  value       = module.shared_vpc.subnet_self_link
}

output "subnet_cidr" {
  description = "Application subnet CIDR."
  value       = module.shared_vpc.subnet_cidr
}

output "host_project_id" {
  description = "Project hosting the Shared VPC."
  value       = google_compute_shared_vpc_host_project.host.project
}

output "workload_project_id" {
  description = "Project attached to the Shared VPC."
  value       = google_compute_shared_vpc_service_project.workload.service_project
}
