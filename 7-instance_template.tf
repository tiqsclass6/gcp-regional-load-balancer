# Defines a regional instance template to launch web server VMs with a startup script and networking settings
resource "google_compute_region_instance_template" "web_template" {
  name         = "web-template"
  project      = var.project_id
  region       = var.region
  machine_type = "e2-medium"
  tags         = ["brazil"] # Insert your target tags here

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-12"
    disk_size_gb = 10
    disk_type    = "pd-balanced"
  }

  network_interface {
    network    = google_compute_network.web_vpc.id
    subnetwork = google_compute_subnetwork.web_subnet.id
    stack_type = "IPV4_ONLY"
    access_config {}
  }

  metadata_startup_script = file("brazil-script.sh") # Insert your custom script here

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
