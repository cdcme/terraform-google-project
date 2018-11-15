terraform {
  required_version = ">= 0.11.0"
}

// Ensure the project exists first
resource "null_resource" "project_id" {
  triggers {
    project_id = "${var.project_id}"
  }
}

// Enables the host project as a Shared VPC host.
// See https://cloud.google.com/vpc/docs/shared-vpc  and
// https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project.html for more information.
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count = "${var.create_vpc_network ? 1 : 0}"

  project = "${var.host_project}"

  lifecycle {
    prevent_destroy = "true"
  }
}

// Enables this project as a Shared VPC service project on the host's shared subnet for this project's region.
resource "google_compute_shared_vpc_service_project" "shared_vpc_project" {
  count = "${var.create_vpc_network ? 1 : 0}"

  host_project    = "${google_compute_shared_vpc_host_project.shared_vpc_host.id}"
  service_project = "${var.project_id}"
  depends_on      = ["null_resource.project_id"]
}

// Access to the VPC host's shared subnet for this region.
data "google_compute_subnetwork" "host_subnet" {
  name    = "default"
  region  = "${var.region}"
  project = "${var.host_project}"
}

resource "google_compute_network" "service_network" {
  count = "${var.create_vpc_network ? 1 : 0}"

  auto_create_subnetworks = "${var.auto_create_subnets}"
  name                    = "${var.network_name == "" ? join("-", list(var.project_id, "net")) : var.network_name}"
  project                 = "${var.project_id}"
  routing_mode            = "${var.routing_mode}"

  depends_on = ["null_resource.project_id"]
}

resource "google_compute_subnetwork" "service_subnet" {
  count = "${var.auto_create_subnets ? 0 : 1}"

  enable_flow_logs         = "${var.flow_logs}"
  ip_cidr_range            = "${data.google_compute_subnetwork.host_subnet.ip_cidr_range}"
  name                     = "${var.subnet_name == "" ? join("-", list(var.project_id, "subnet")) : var.subnet_name}"
  network                  = "${google_compute_network.service_network.name}"
  private_ip_google_access = "${var.private_access}"
  project                  = "${var.project_id}"
  region                   = "${var.region}"
}

// To allow SSH to work in Cloud Console but not anywhere else,
// we need to allow SSH from any of Google's IPs
// If SSH stops working in Cloud Console, update locals with the output from
// https://gist.github.com/carlodicelico/b33191e9ab6f19672ba1c6fb0915cbbc
resource "google_compute_firewall" "vault-ssh-fw" {
  count = "${var.create_ssh_fw_rule ? 1 : 0}"

  project = "${var.project_id}"
  name    = "${var.fw_rule_name == "" ? join("-", list(var.project_id, "fw-ssh")) : var.fw_rule_name}"
  network = "${google_compute_network.service_network.name}"

  allow {
    protocol = "tcp"
    ports    = [22]
  }

  source_ranges = "${concat(local.gcp_netblocks)}"
}

// Grant appropriate roles to the project service account.
resource "google_project_iam_member" "project_vpc_member" {
  count = "${var.create_vpc_network ? 1 : 0}"

  member  = "serviceAccount:${var.service_account_email}"
  project = "${var.project_id}"
  role    = "roles/compute.networkUser"

  depends_on = ["null_resource.project_id"]
}

resource "google_compute_subnetwork_iam_member" "project_vpc_subnet_member" {
  count = "${var.create_vpc_network ? 1 : 0}"

  member     = "serviceAccount:${var.service_account_email}"
  project    = "${var.project_id}"
  provider   = "google-beta"
  region     = "${var.region}"
  role       = "roles/compute.networkUser"
  subnetwork = "${google_compute_subnetwork.service_subnet.name}"
}
