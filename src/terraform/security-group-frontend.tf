resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Be cautious: This allows SSH from any IP. Adjust as necessary.
  target_tags   = ["ssh-access"]
}