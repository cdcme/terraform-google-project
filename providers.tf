provider "external" {
  version = "~> 1.2"
}

provider "google" {
  credentials = file(var.gcloud_credentials)
  project     = local.project_id
  region      = var.region
  version     = "~> 3.22.0"
}

provider "google-beta" {
  credentials = file(var.gcloud_credentials)
  project     = local.project_id
  region      = var.region
  version     = "~> 3.22.0"
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1.2"
}

provider "random" {
  version = "~> 2.2.1"
}

provider "template" {
  version = "~> 2.1.2"
}

