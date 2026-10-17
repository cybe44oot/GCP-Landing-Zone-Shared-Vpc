output "landing_zone_folder_id" {
  description = "Numeric ID of the landing zone folder."
  value       = google_folder.landing_zone.folder_id
}

output "landing_zone_folder_name" {
  description = "Resource name of the landing zone folder."
  value       = google_folder.landing_zone.name
}

output "host_project_id" {
  description = "Project ID of the Shared VPC host."
  value       = google_project.host.project_id
}

output "host_project_number" {
  description = "Project number of the Shared VPC host."
  value       = google_project.host.number
}

output "workload_project_id" {
  description = "Project ID of the workload service project."
  value       = google_project.workload.project_id
}

output "workload_project_number" {
  description = "Project number of the workload service project."
  value       = google_project.workload.number
}
