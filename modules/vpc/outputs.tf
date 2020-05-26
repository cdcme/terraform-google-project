output "name" {
  value       = google_compute_network.service_network.*.name
  description = "The unique name for the VPC network, required by GCE."
}

output "auto_create_subnetworks" {
  value       = google_compute_network.service_network.*.auto_create_subnetworks
  description = "Whether or not subnets will be (in plan) or were (in apply) automatically created on this VPC."
}

output "routing_mode" {
  value       = google_compute_network.service_network.*.routing_mode
  description = "The network-wide routing mode for Cloud Routers.."
}

output "gateway_ipv4" {
  value       = google_compute_network.service_network.*.gateway_ipv4
  description = "The IPv4 address of the gateway."
}

output "self_link" {
  value       = google_compute_network.service_network.*.self_link
  description = "The URI of the created resource."
}

output "subnets" {
  value       = google_compute_subnetwork.service_subnet.*.name
  description = "The VPC subnets that will be (in plan) or were (in apply) created."
}

output "ips" {
  value       = google_compute_subnetwork.service_subnet.*.ip_cidr_range
  description = "The VPC subnets IP range in CIDR format."
}

output "private_access" {
  value       = google_compute_subnetwork.service_subnet.*.private_ip_google_access
  description = "Whether you have allowed private access to Google APIs without an external IP address."
}

output "flow_logs" {
  value       = google_compute_subnetwork.service_subnet.*.enable_flow_logs
  description = "Whether you have enabled flow logging for the Shared VPC subnetwork."
}

