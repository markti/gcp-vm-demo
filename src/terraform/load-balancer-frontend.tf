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

resource "google_compute_http_health_check" "frontend" {
  name               = "${var.application_name}-${var.environment_name}-frontend"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}