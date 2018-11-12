/**
* REQUIRED PARAMETERS
* These parameters must be supplied when consuming this module.
*/

variable "host_project" {
  description = "The project ID of the GCP project used by Terraform to create this project."
}

variable "organization_id" {
  description = "The ID of your organization in GCP Cloud Console."
}

variable "billing_account" {
  description = "The billing account ID to enable for this project."
}

/**
* OPTIONAL PARAMETERS
* These parameters have reasonable defaults.
*/

// Project configuration

// Create the 'default' network automatically. Note: this might be more accurately described as "Delete Default Network",
// since the network is created automatically then deleted before project creation returns.
// See https://www.terraform.io/docs/providers/google/r/google_project.html#auto_create_network
variable "auto_create_network" {
  description = "Create the 'default' network automatically."
  default     = "false"
}

variable "create_encryption_resources" {
  description = "Whether or not to create GCP KMS resources. If `'true'`, all encrypted resources will use the customer-managed key."
  default     = "true"
}

variable "create_project_bucket" {
  description = "Whether or not to create a GCS bucket for this project. If `'true'`, a logging bucket will automatically be created and logging will be enabled. If `configure_kms` is `'true`, any buckets created will be configured with encryption enabled using your project's KMS key."
  default     = "true"
}

variable "display_name" {
  description = "The name that will be displayed in GCP Cloud Console's interface."
  default     = ""
}

variable "project_storage_class" {
  description = "The storage class to use for your project's storage and logging buckets."
  default     = "REGIONAL"
}

variable "create_tfstate_bucket" {
  description = "Whether or not to create a bucket for Terraform state in your `host_project`, if defined."
  default     = "true"
}

variable "tfstate_storage_class" {
  description = "The storage class to use for your Terraform state bucket."
  default     = "REGIONAL"
}

variable "create_usage_reporting_bucket" {
  description = "Whether or not to create a bucket for your project's GCE usage reporting."
  default     = "false"
}

variable "custom_id" {
  description = "Custom project ID if not using `random_id`. Either `custom_id` must be specified or `random_id` must be true."
  default     = ""
}

variable "gcloud_credentials" {
  description = "Path to the service account credentials used by the Terraform host project."
  default     = "~/.config/gcloud/credentials.json"
}

variable "enable_apis" {
  description = "Which APIs to enable for this project."
  type        = "list"
  default     = ["compute.googleapis.com", "cloudbilling.googleapis.com"]
}

variable "folder_id" {
  description = "A folder to create this project under. If none is provided, the project will be created under the organization."
  default     = ""
}

variable "id_prefix" {
  description = "A prefix to use with your `custom_id` or `random_id`."
  default     = ""
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the project."
  type        = "map"

  default = {
    environment = "development"
  }
}

variable "random_id" {
  description = "Whether or not to generate a random project ID. Either `custom_id` must be specified or `random_id` must be true."
  default     = "true"
}

variable "random_prefix" {
  description = "Whether or not to generate a random prefix for your project ID. If you want to use a `custom_id` and don't want a prefix, set this to `'false'` and don't set a value for `id_prefix`."
  default     = "true"
}

variable "region" {
  description = "The preferred region to use for resources that require a region to be defined."
  default     = "us-central1"
}

variable "skip_delete" {
  description = " If true, the Terraform resource can be deleted without deleting the Project via the Google API."
  default     = "false"
}
