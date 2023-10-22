
resource "google_service_account" "default" {
  account_id   = "${var.application_name}-${var.environment_name}-sa"
  display_name = "Custom SA for VM Instance"
}

data "google_compute_image" "frontend" {
  name = var.frontend_image_name
}

resource "google_compute_instance" "frontend" {

  count = var.frontend_instance_count

  name         = "vm${var.application_name}-${var.environment_name}-frontend-${count.index}"
  machine_type = var.frontend_machine_type
  zone         = local.azs_random[count.index % 2]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.frontend.self_link
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.frontend.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  tags = ["ssh-access", "frontend-access"]

}