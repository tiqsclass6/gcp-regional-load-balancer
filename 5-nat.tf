# Creates a Cloud Router to manage dynamic routes and NAT configuration for the VPC
resource "google_compute_router" "web_router" {
  name    = "web-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.web_vpc.id
}

# Configures Cloud NAT for the VPC to allow private instances to access the internet
resource "google_compute_router_nat" "web_nat" {
  name                                = "web-nat"
  router                              = google_compute_router.web_router.name
  project                             = var.project_id
  region                              = var.region
  nat_ip_allocate_option              = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  enable_endpoint_independent_mapping = true
}
