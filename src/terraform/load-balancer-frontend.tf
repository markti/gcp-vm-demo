/*
resource "google_compute_forwarding_rule" "frontend" {
  name   = "lb-${var.application_name}-${var.environment_name}-frontend"
  region = var.primary_region

}

resource "google_compute_target_pool" "frontend" {
  name = "${var.application_name}-${var.environment_name}-frontend"

}

resource "google_compute_http_health_check" "frontend" {
  name = "${var.application_name}-${var.environment_name}-frontend"

}
*/