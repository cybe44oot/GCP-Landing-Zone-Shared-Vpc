provider "google" {
  project = var.project_id
}

output "organization_id" {
  value = var.org_id
}

output "validation_project" {
  value = var.project_id
}