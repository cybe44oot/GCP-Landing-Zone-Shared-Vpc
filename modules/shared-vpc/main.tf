resource "google_compute_network" "shared" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Custom-mode Shared VPC for the landing zone"

  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "application" {
  project                  = var.project_id
  name                     = var.subnet_name
  region                   = var.region
  network                  = google_compute_network.shared.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = var.private_google_access

  description = "Application subnet for landing zone workloads"
}
