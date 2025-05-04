# Outputs the external IP address of the HTTP load balancer for easy access
output "load_balancer_ip" {
  value = google_compute_forwarding_rule.web_forwarding_rule.ip_address
}
