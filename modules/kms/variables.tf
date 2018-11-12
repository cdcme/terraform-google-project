/**
* REQUIRED PARAMETERS
* These parameters must be supplied when consuming this module.
*/

variable "create_encryption_resources" {
  description = "Whether or not to create GCP KMS resources."
}

variable "project_id" {
  description = "The project ID."
}

variable "region" {
  description = "The preferred region to use for resources that require a region to be defined."
}

variable "service_account_email" {
  description = "The email address of the project SA to grant access to encryption resources."
}

/**
* OPTIONAL PARAMETERS
* These parameters have reasonable defaults.
*/

variable "kms_crypto_key_roles" {
  type = "list"

  default = [
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
  ]
}

variable "rotation_period" {
  description = "Generate a new CryptoKeyVersion and set it as the primary this often."
  default     = "604800s"
}
