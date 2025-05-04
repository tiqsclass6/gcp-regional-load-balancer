# Creates a standard subnet for web server instances in the specified region
resource "google_compute_subnetwork" "web_subnet" {
  name          = "web-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.web_vpc.id
  ip_cidr_range = "10.233.40.0/24"
}

# Creates a proxy-only subnet for use with regional external HTTP(S) load balancers
resource "google_compute_subnetwork" "lb_proxy_only_subnet" {
  name          = "lb-proxy-only-subnet"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.web_vpc.id
  ip_cidr_range = "10.233.90.0/24"
}
