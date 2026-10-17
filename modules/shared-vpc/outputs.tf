output "network_id" {
  description = "ID of the Shared VPC network."
  value       = google_compute_network.shared.id
}

output "network_self_link" {
  description = "Self link of the Shared VPC network."
  value       = google_compute_network.shared.self_link
}

output "subnet_id" {
  description = "ID of the application subnet."
  value       = google_compute_subnetwork.application.id
}

output "subnet_self_link" {
  description = "Self link of the application subnet."
  value       = google_compute_subnetwork.application.self_link
}

output "subnet_cidr" {
  description = "IPv4 range allocated to the application subnet."
  value       = google_compute_subnetwork.application.ip_cidr_range
}
