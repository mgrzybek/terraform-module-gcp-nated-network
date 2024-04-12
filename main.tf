resource "google_compute_network" "private_nated_network" {
  name                    = "private-nated-net"
  auto_create_subnetworks = false
  mtu                     = 1450
}

resource "google_compute_subnetwork" "private_nated_subnetwork" {
  name          = "private-nated-subnet"
  ip_cidr_range = var.cidr
  region        = "europe-west9"
  network       = google_compute_network.private_nated_network.id
}

resource "google_compute_router" "nat_router_eu_west9" {
  name    = "nat-router-eu-west9"
  region  = "europe-west9"
  network = google_compute_network.private_nated_network.id
}

resource "google_compute_router_nat" "nat-config" {
  name                               = "nat-config"
  router                             = google_compute_router.nat_router_eu_west9.name
  region                             = "europe-west9"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "ssh-gcp" {
  name    = "ssh-gcp"
  network = google_compute_network.private_nated_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["ssh"]
  source_ranges = [
    "35.235.240.0/20",
    var.cidr
  ]
}