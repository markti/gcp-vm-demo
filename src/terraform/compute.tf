
resource "google_service_account" "default" {
  account_id   = "${var.application_name}-${var.environment_name}-sa"
  display_name = "Custom SA for VM Instance"
}
/*
resource "google_compute_instance" "default" {

  count = var.az_count

  name         = "vm${var.application_name}-${var.environment_name}-frontend-${count.index}"
  machine_type = var.frontend_machine_type
  zone         = local.azs_random[count.index]

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = var.frontend_image_name
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

}
*/