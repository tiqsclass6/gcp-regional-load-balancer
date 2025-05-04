# Allows inbound HTTP (port 80) traffic from any source to instances tagged "brazil"
resource "google_compute_firewall" "allow_http_to_lb" {
  name      = "allow-http-and-hc-to-lb"
  project   = var.project_id
  network   = google_compute_network.web_vpc.id
  priority  = 1000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["brazil"] # Insert your target tags here
}
