// Bucket for logging access to the project store.
resource "google_storage_bucket" "logs" {
  count         = "${var.create_project_bucket ? 1 : 0}"
  name          = "${var.name_prefix}-logs"
  location      = "${var.location}"
  project       = "${var.project_id}"
  storage_class = "${var.storage_class}"

  encryption {
    default_kms_key_name = "${var.default_kms_key_name}"
  }

  // To prevent accidental destruction, you must manually destroy this bucket.
  lifecycle {
    prevent_destroy = "true"
  }
}

// Bucket for project sensitive object storage with versioning enabled, optional KMS key encryption, and logging.
resource "google_storage_bucket" "store" {
  count         = "${var.create_project_bucket ? 1 : 0}"
  name          = "${var.name_prefix}-store"
  location      = "${var.location}"
  project       = "${var.project_id}"
  storage_class = "${var.storage_class}"

  versioning {
    enabled = "true"
  }

  encryption {
    default_kms_key_name = "${var.default_kms_key_name}"
  }

  logging {
    log_bucket = "${google_storage_bucket.logs.name}"
  }

  // To prevent accidental destruction, you must manually destroy this bucket.
  lifecycle {
    prevent_destroy = "true"
  }
}

////  Grant storage.admin to group for the secure bucket
//resource "google_storage_bucket_iam_member" "group_storage_admin_on_secure_bucket" {
//  bucket = "${google_storage_bucket.vault-secure.name}"
//  role   = "roles/storage.admin"


//  // TODO: expose the group name as an output in the project base
//  member = "group:${local.custom_project_id}-editors@minnow.me"
//}


////  Grant storage.admin to default compute service account for the secure bucket
//resource "google_storage_bucket_iam_member" "sa_storage_admin_on_secure_bucket" {
//  bucket = "${google_storage_bucket.vault-secure.name}"
//  role   = "roles/storage.admin"
//  member = "serviceAccount:${module.project.service_account_email}"
//}


//// Grant storage.admin to Google APIs service account for the secure bucket
//resource "google_storage_bucket_iam_member" "api_sa_storage_admin_on_secure_bucket" {
//  bucket = "${google_storage_bucket.vault-secure.name}"
//  role   = "roles/storage.admin"
//  member = "serviceAccount:${module.project.service_account_email}"
//}


////  Grant storage.admin to group for the secure bucket logs
//resource "google_storage_bucket_iam_member" "group_storage_admin_on_secure_bucket_logs" {
//  bucket = "${google_storage_bucket.vault-secure-logs.name}"
//  role   = "roles/storage.admin"


//  // TODO: expose the group name as an output in the project base
//  member = "group:${local.custom_project_id}-editors@minnow.me"
//}


////  Grant storage.admin to default compute service account for the secure bucket logs
//resource "google_storage_bucket_iam_member" "sa_storage_admin_on_secure_bucket_logs" {
//  bucket = "${google_storage_bucket.vault-secure-logs.name}"
//  role   = "roles/storage.admin"
//  member = "serviceAccount:${module.project.service_account_email}"
//}


//// Grant storage.admin to Google APIs service account for the secure bucket logs
//resource "google_storage_bucket_iam_member" "api_sa_storage_admin_on_secure_bucket_logs" {
//  bucket = "${google_storage_bucket.vault-secure-logs.name}"
//  role   = "roles/storage.admin"
//  member = "serviceAccount:${module.project.service_account_email}"
//}

