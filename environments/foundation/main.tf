provider "google" {
  user_project_override = false
}

resource "google_folder" "landing_zone" {
  display_name = var.folder_name
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "host" {    #Act as a Network Owner
  name            = "ALZ Lab - Shared VPC Host"
  project_id      = var.host_project_id
  folder_id       = google_folder.landing_zone.name
  billing_account = var.billing_account_id

  auto_create_network = false
  deletion_policy     = "DELETE"  #Allows Terraform to delete this project when the resource is destroyed, subject to GCP permissions and other constraints

  labels = {
    environment = "lab"
    purpose     = "shared-vpc-host"
    managed_by  = "terraform"
  }
}

resource "google_project" "workload" {    #Intended to own application resources
  name            = "ALZ Lab - Workload"
  project_id      = var.workload_project_id
  folder_id       = google_folder.landing_zone.name
  billing_account = var.billing_account_id

  auto_create_network = false
  deletion_policy     = "DELETE"

  labels = {
    environment = "lab"
    purpose     = "workload"
    managed_by  = "terraform"
  }
}

# The key design decision: the workload project does not need to own a separate VPC just to run its application. It can use the Shared VPC network owned by the host project