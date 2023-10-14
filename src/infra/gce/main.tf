resource "google_compute_network" "money-tracker-network" {
  name                    = "money-tracker-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "money-tracker-asia" {
  name          = "money-tracker-asia"
  ip_cidr_range = "10.10.20.0/28"
  network       = google_compute_network.money-tracker-network.self_link
  region        = "asia-southeast2"
}

resource "google_compute_firewall" "allow-http-money-tracker-fe" {
  name          = "allow-http-money-tracker-fe"
  network       = google_compute_network.money-tracker-network.self_link
  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  target_tags   = ["frontend"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_address" "money-tracker-fe-ip" {
  name         = "money-tracker-fe-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "money-tracker-fe" {
  name         = "money-tracker-fe"
  machine_type = "e2-micro"
  tags         = ["frontend"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = "10"
      type  = "pd-ssd"
    }
  }

  network_interface {
    network    = google_compute_network.money-tracker-network.self_link
    subnetwork = google_compute_subnetwork.money-tracker-asia.self_link
    access_config {
      nat_ip = google_compute_address.money-tracker-fe-ip.address
    }
  }
}
