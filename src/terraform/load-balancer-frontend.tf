resource "google_compute_forwarding_rule" "frontend" {
  name       = "lb-${var.application_name}-${var.environment_name}-frontend"
  region     = var.primary_region
  port_range = 80
  target     = google_compute_target_pool.frontend.self_link
}

resource "google_compute_target_pool" "frontend" {
  name = "${var.application_name}-${var.environment_name}-frontend"

  instances = google_compute_instance.frontend.*.self_link

  health_checks = [
    google_compute_http_health_check.frontend.name,
  ]
}

resource "google_compute_http_health_check" "frontend" {
  name               = "${var.application_name}-${var.environment_name}-frontend"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
  port               = 5001
}