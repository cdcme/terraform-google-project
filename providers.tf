provider "external" {
  version = "~> 1.0"
}

provider "google" {
  credentials = "${file(var.gcloud_credentials)}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  version     = "~> 1.19.1"
}

provider "google-beta" {
  credentials = "${file(var.gcloud_credentials)}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  version     = "~> 1.19.0"
}

provider "local" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 1.0"
}

provider "random" {
  version = "~> 2.0"
}

provider "template" {
  version = "~> 1.0"
}
