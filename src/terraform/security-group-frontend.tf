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

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["frontend-access"]
}