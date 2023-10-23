resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Be cautious: This allows SSH from any IP. Adjust as necessary.
  target_tags   = ["ssh-access"]
}

resource "google_compute_firewall" "frontend_allow_http" {
  name    = "allow-frontend-http"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }

  source_ranges           = ["130.211.0.0/22", "35.191.0.0/16"]
  target_service_accounts = [google_service_account.main.email]
}

resource "google_compute_firewall" "allow-external-to-lb" {
  name    = "allow-external-to-lb"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges           = ["35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]
  target_service_accounts = [google_service_account.main.email]
}