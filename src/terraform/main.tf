data "google_project" "main" {
}

data "google_compute_zones" "available" {
  region = var.primary_region
}

resource "random_shuffle" "az" {
  input        = data.google_compute_zones.available.names
  result_count = var.az_count
}

locals {
  azs_random = random_shuffle.az.result
}