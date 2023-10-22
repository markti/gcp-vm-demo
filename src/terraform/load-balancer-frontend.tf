resource "google_compute_router" "frontend" {
  name    = "lb-${var.application_name}-${var.environment_name}-frontend"
  network = google_compute_network.main.self_link
  region  = google_compute_subnetwork.frontend.region
}

resource "google_compute_target_pool" "frontend" {
  name = "instance-pool"

  instances = google_compute_instance.frontend.*.self_link

  health_checks = [
    google_compute_http_health_check.frontend.name,
  ]
}

resource "google_compute_health_check" "frontend" {
  name = "hc-${var.application_name}-${var.environment_name}-frontend"

  timeout_sec         = 1
  check_interval_sec  = 1
  healthy_threshold   = 4
  unhealthy_threshold = 5

  tcp_health_check {
    port = "5000"
  }
}
