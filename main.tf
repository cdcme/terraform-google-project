/**
* Module main.
*/

terraform {
  required_version = ">= 0.10.3"
}

// Create a basic project.
resource "google_project" "project" {
  auto_create_network = "${var.auto_create_network}"
  billing_account     = "${var.billing_account}"
  folder_id           = "${var.folder_id}"
  labels              = "${var.labels}"
  name                = "${local.project_name}"

  // Only one of `org_id` or `folder_id` may be specified, so we prefer the folder here.
  // Note that `organization_id` is required, making this safe.
  org_id = "${var.folder_id == "" ? var.organization_id : var.folder_id}"

  project_id  = "${local.project_id}"
  skip_delete = "${var.skip_delete}"
}

// Enable the requested APIs.
resource "google_project_service" "gcp_apis" {
  count   = "${length(var.enable_apis)}"
  project = "${google_project.project.id}"
  service = "${element(var.enable_apis, count.index)}"
}

// Remove the project's default service account.
// See https://cloud.google.com/iam/docs/service-accounts#google-managed_service_accounts
resource "null_resource" "remove_default_compute_sa" {
  provisioner "local-exec" {
    command = "gcloud iam service-accounts delete --project=${google_project.project.id} ${data.google_compute_default_service_account.details.email}"
  }

  triggers {
    default_compute_sa = "${data.google_compute_default_service_account.details.id}"
    enabled_apis       = "${join(",", var.enable_apis)}"
  }

  depends_on = ["google_project_service.gcp_apis", "data.google_compute_default_service_account.details"]
}

// Create a new project default service account.
resource "google_service_account" "project_default" {
  account_id   = "project-default"
  display_name = "${google_project.project.name} Project Service Account"
  project      = "${google_project.project.id}"
}

// Create a bucket for this project's tfstate in the host project.
// You'll want to create a backend.tf pointing to it:
/**
terraform {
  backend "gcs" {
    prefix  = "tfstate/"
    bucket  = "<your-bucket-name>"
    project = "<your-project-id>"
  }
}
*/
resource "google_storage_bucket" "tfstate" {
  count         = "${var.create_tfstate_bucket ? 1 : 0}"
  force_destroy = "false"
  location      = "${var.region}"
  name          = "${google_project.project.id}"
  project       = "${var.host_project}"
  storage_class = "${var.tfstate_storage_class}"

  versioning {
    enabled = "true"
  }

  lifecycle {
    prevent_destroy = "true"
  }
}

/**
* Additional project resources. If you use these modules independently, remember to use version pinning
* and Terraform's module syntax (github.com/minnowpod/terraform-google-project//modules/kms?ref=v0.1.0).
* See https://www.terraform.io/docs/modules/sources.html for more information.
*/

// Project encryption resources.
module "encryption" {
  source                      = "./modules/kms"
  create_encryption_resources = "${var.create_encryption_resources}"
  project_id                  = "${google_project.project.id}"
  region                      = "${var.region}"
  service_account_email       = "${google_service_account.project_default.email}"
}

// Storage resources, intended for sensitive project-wide data, not for specific (public web, files, etc.) use cases.
module "storage" {
  create_project_bucket = "${var.create_project_bucket}"
  default_kms_key_name  = "${var.create_encryption_resources ? module.encryption.key_name : ""}"
  location              = "${var.region}"
  name_prefix           = "${google_project.project.id}"
  project_id            = "${google_project.project.id}"
  source                = "./modules/gcs"
  storage_class         = "${var.project_storage_class}"
}
