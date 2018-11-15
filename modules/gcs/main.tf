terraform {
  required_version = ">= 0.11.0"
}

// Ensure the project and KMS resources exist first
resource "null_resource" "project_id" {
  triggers {
    project_id = "${var.project_id}"
  }
}

resource "null_resource" "default_kms_key_name" {
  triggers {
    default_kms_key_name = "${var.default_kms_key_name}"
  }
}

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

  depends_on = ["null_resource.project_id", "null_resource.default_kms_key_name"]
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

//  Grant storage.admin to the project's default service account for the storage and logging buckets
resource "google_storage_bucket_iam_member" "project_store_admin" {
  bucket = "${google_storage_bucket.store.name}"
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_storage_bucket_iam_member" "project_logging_admin" {
  bucket = "${google_storage_bucket.logs.name}"
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}
