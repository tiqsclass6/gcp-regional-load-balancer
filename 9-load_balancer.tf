resource "google_compute_region_health_check" "lb_health_check" {
  name    = "lb-health-check"
  project = var.project_id
  region  = var.region

  tcp_health_check {
    port = 80
  }
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}

resource "google_compute_region_backend_service" "web_backend_service" {
  name                  = "web-backend"
  protocol              = "HTTP"
  project               = var.project_id
  region                = var.region
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30
  health_checks         = [google_compute_region_health_check.lb_health_check.id]

  backend {
    group           = google_compute_region_instance_group_manager.web_mig.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }

  port_name                       = "http"
  connection_draining_timeout_sec = 300
}

resource "google_compute_region_url_map" "web_url_map" {
  name            = "web-url-map"
  project         = var.project_id
  region          = var.region
  default_service = google_compute_region_backend_service.web_backend_service.id
}

resource "google_compute_region_target_http_proxy" "web-lb-target-proxy" {
  name    = "web-lb-target-proxy"
  project = var.project_id
  region  = var.region
  url_map = google_compute_region_url_map.web_url_map.id
}

resource "google_compute_forwarding_rule" "web_forwarding_rule" {
  name                  = "web-frontend"
  project               = var.project_id
  region                = var.region
  load_balancing_scheme = "EXTERNAL_MANAGED"
  network               = google_compute_network.web_vpc.id
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.web-lb-target-proxy.id
}
