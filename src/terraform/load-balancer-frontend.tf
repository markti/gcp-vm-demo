
resource "google_compute_forwarding_rule" "main" {
  name                  = "${var.application_name}-${var.environment_name}"
  target                = google_compute_target_pool.main.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = 80
  region                = var.primary_region
  ip_protocol           = "tcp"
}

resource "google_compute_target_pool" "main" {
  name             = "${var.application_name}-${var.environment_name}"
  region           = var.primary_region
  session_affinity = "CLIENT_IP"
  instances        = google_compute_instance.frontend.*.self_link
  health_checks    = [google_compute_http_health_check.main.self_link]
}

resource "google_compute_http_health_check" "main" {
  name = "${var.application_name}-${var.environment_name}-hc"

  port         = 5000
  request_path = "/"
}