// Ensure the project is created first
resource "null_resource" "project_id" {
  triggers = {
    project_id = var.project_id
  }
}

// Enable the Cloud KMS API.
resource "google_project_service" "kms_api" {
  count      = var.create_encryption_resources ? 1 : 0
  project    = var.project_id
  service    = "cloudkms.googleapis.com"
  depends_on = [null_resource.project_id]
}

// Create a KMS key ring for storing keys for this project.
resource "google_kms_key_ring" "project" {
  count = var.create_encryption_resources ? 1 : 0

  location = var.region
  name     = "${var.project_id}-kms-ring"
  project  = var.project_id

  depends_on = [google_project_service.kms_api]
}

// Create a project encryption key, and prevent its destruction.
// Note that encrypting and decrypting of sensitive objects is best done *outside* of Terraform altogether!
resource "google_kms_crypto_key" "project" {
  count = var.create_encryption_resources ? 1 : 0

  key_ring        = google_kms_key_ring.project[0].id
  name            = "${var.project_id}-kms-key"
  rotation_period = var.rotation_period

  lifecycle {
    prevent_destroy = "true"
  }
}

// Give the project SA access to the key, with any roles defined in `kms_crypto_key_roles`.
resource "google_kms_crypto_key_iam_member" "project-sa" {
  count = var.create_encryption_resources ? length(var.kms_crypto_key_roles) : 0

  crypto_key_id = google_kms_crypto_key.project[0].id
  member        = "serviceAccount:${var.service_account_email}"
  role          = element(var.kms_crypto_key_roles, count.index)
}

