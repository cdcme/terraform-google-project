output "labels" {
  description = "A set of key/value label pairs to assign to the project."
  value       = "${google_project.project.labels}"
}

output "id" {
  description = "The project ID."
  value       = "${google_project.project.id}"
}

output "name" {
  description = "The display name of the project."
  value       = "${google_project.project.name}"
}

output "number" {
  description = "The numeric identifier of the project."
  value       = "${google_project.project.number}"
}

output "service_account" {
  description = "Project default service account details."

  value = {
    display_name = "${google_service_account.project_default.name}"
    email        = "${google_service_account.project_default.email}"
    id           = "${google_service_account.project_default.id}"
    unique_id    = "${google_service_account.project_default.unique_id}"
  }
}

output "tfstate_bucket" {
  description = "Project Terraform state bucket details."

  value = {
    name          = "${google_storage_bucket.tfstate.*.name}"
    project       = "${google_storage_bucket.tfstate.*.project}"
    region        = "${google_storage_bucket.tfstate.*.location}"
    self_link     = "${google_storage_bucket.tfstate.*.self_link}"
    storage_class = "${google_storage_bucket.tfstate.*.storage_class}"
    url           = "${google_storage_bucket.tfstate.*.url}"
    versioning    = "${google_storage_bucket.tfstate.*.versioning}"
  }
}

output "kms" {
  description = "Project KMS resource details."

  value = {
    keyring_location    = "${module.encryption.keyring_location}"
    keyring_name        = "${module.encryption.keyring_name}"
    keyring_self_link   = "${module.encryption.keyring_self_link}"
    key_name            = "${module.encryption.key_name}"
    key_keyring         = "${module.encryption.key_keyring}"
    key_rotation_period = "${module.encryption.key_rotation_period}"
    key_self_link       = "${module.encryption.key_self_link}"
  }
}

output "storage" {
  description = "Project GCS bucket details."

  value = {
    logging_bucket_name      = "${module.storage.logging_bucket_name}"
    logging_bucket_self_link = "${module.storage.logging_bucket_self_link}"
    logging_bucket_url       = "${module.storage.logging_bucket_url}"
    store_bucket_name        = "${module.storage.store_bucket_name}"
    store_bucket_self_link   = "${module.storage.store_bucket_self_link}"
    store_bucket_url         = "${module.storage.store_bucket_url}"
  }
}
