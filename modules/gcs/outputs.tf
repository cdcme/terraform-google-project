output "logging_bucket_name" {
  value = google_storage_bucket.logs.*.name
}

output "logging_bucket_self_link" {
  value = google_storage_bucket.logs.*.self_link
}

output "logging_bucket_url" {
  value = google_storage_bucket.logs.*.url
}

output "store_bucket_name" {
  value = google_storage_bucket.store.*.name
}

output "store_bucket_self_link" {
  value = google_storage_bucket.store.*.self_link
}

output "store_bucket_url" {
  value = google_storage_bucket.store.*.url
}

