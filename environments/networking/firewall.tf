resource "google_compute_firewall" "allow_web_from_lab_subnet" {
  project     = var.project_id
  name        = "alz-allow-web-from-lab-subnet"
  network     = module.shared_vpc.network_self_link
  description = "Allow HTTP and HTTPS from the lab subnet to tagged web workloads"

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.subnet_cidr]
  target_tags   = ["alz-web"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}
