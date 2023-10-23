resource "google_compute_network" "main" {
  name                    = "${var.application_name}-${var.environment_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "frontend" {
  name          = "frontend"
  region        = var.primary_region
  network       = google_compute_network.main.self_link
  ip_cidr_range = cidrsubnet(var.network_cidr_block, 2, 1)
}
resource "google_compute_subnetwork" "backend" {
  name          = "backend"
  region        = var.primary_region
  network       = google_compute_network.main.self_link
  ip_cidr_range = cidrsubnet(var.network_cidr_block, 2, 2)
}

resource "google_compute_router" "main" {
  name    = "router-${var.application_name}-${var.environment_name}"
  region  = var.primary_region
  network = google_compute_network.network.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "router-nat-${var.application_name}-${var.environment_name}"
  router                             = google_compute_router.main.name
  region                             = google_compute_router.main.region
  icmp_idle_timeout_sec              = 30
  min_ports_per_vm                   = 64
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  tcp_established_idle_timeout_sec   = 1200
  tcp_transitory_idle_timeout_sec    = 30
  tcp_time_wait_timeout_sec          = 120
  udp_idle_timeout_sec               = 30
  enable_dynamic_port_allocation     = false
}