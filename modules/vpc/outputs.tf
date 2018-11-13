output "name" {
  value = "${google_compute_network.service_network.*.name}"
}

output "auto_create_subnetworks" {
  value = "${google_compute_network.service_network.*.auto_create_subnetworks}"
}

output "routing_mode" {
  value = "${google_compute_network.service_network.*.routing_mode}"
}

output "gateway_ipv4" {
  value = "${google_compute_network.service_network.*.gateway_ipv4}"
}

output "self_link" {
  value = "${google_compute_network.service_network.*.self_link}"
}
