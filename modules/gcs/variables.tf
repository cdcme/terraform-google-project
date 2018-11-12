/**
* REQUIRED PARAMETERS
* These parameters must be supplied when consuming this module.
*/

variable "default_kms_key_name" {
  description = "The KMS key name to use for encryption/decryption of project storage objects."
}

variable "project_id" {
  description = "The project ID."
}

/**
* OPTIONAL PARAMETERS
* These parameters have reasonable defaults.
*/

variable "create_project_bucket" {
  description = "Whether or not to create a GCS bucket for this project. If `'true'`, a logging bucket will automatically be created and logging will be enabled. If `configure_kms` is `'true`, any buckets created will be configured with encryption enabled using your project's KMS key."
  default     = "true"
}

variable "name_prefix" {
  description = "A prefix for your bucket names (not a storage prefix path)."
  default     = ""
}

variable "location" {
  description = "The location to create your project's storage resources in"
  default     = "US"
}

variable "storage_class" {
  description = "The storage class for your bucket."
  default     = "MULTIREGIONAL"
}
