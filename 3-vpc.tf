# Creates a custom Virtual Private Cloud (VPC) with regional routing and no auto subnet creation
resource "google_compute_network" "web_vpc" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}
