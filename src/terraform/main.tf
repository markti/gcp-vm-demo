data "google_compute_zones" "available" {
}

resource "random_shuffle" "az" {
  input        = data.google_compute_zones.available.names
  result_count = var.az_count
}