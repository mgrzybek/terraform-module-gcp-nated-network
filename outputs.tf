output "network_id" {
  value = google_compute_network.private_nated_network.id
  description = "Id du réseau privé"
}

output "subnetwork_id" {
 value = google_compute_subnetwork.private_nated_subnetwork.id
  description = "Id du sous-réseau privé"
}