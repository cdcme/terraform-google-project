output "keyring_location" {
  value = google_kms_key_ring.project.*.location
}

output "keyring_name" {
  value = google_kms_key_ring.project.*.name
}

output "keyring_project" {
  value = google_kms_key_ring.project.*.project
}

output "keyring_self_link" {
  value = google_kms_key_ring.project.*.self_link
}

output "key_name" {
  value = google_kms_crypto_key.project.*.name
}

output "key_keyring" {
  value = google_kms_crypto_key.project.*.key_ring
}

output "key_rotation_period" {
  value = google_kms_crypto_key.project.*.rotation_period
}

output "key_self_link" {
  value = google_kms_crypto_key.project.*.self_link
}

