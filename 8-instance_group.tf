# Creates a regional Managed Instance Group (MIG) to deploy and manage multiple Apache web server instances
resource "google_compute_region_instance_group_manager" "web_mig" {
  name    = "web-mig"
  project = var.project_id
  region  = var.region

  version {
    instance_template = google_compute_region_instance_template.web_template.id
    name              = "web-mig-version"
  }

  base_instance_name = "web-mig"
  target_size        = 3

  auto_healing_policies {
    health_check      = google_compute_region_health_check.lb_health_check.id
    initial_delay_sec = 300
  }

  named_port {
    name = "http"
    port = 80
  }
}

# Configures a basic TCP health check on port 80 for auto-healing of MIG instances
resource "google_compute_health_check" "mig_health_check" {
  name    = "mig-health-check"
  project = var.project_id

  tcp_health_check {
    port = 80
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}
