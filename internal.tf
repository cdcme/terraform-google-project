/**
* Module internal resources.
*/

// Generate a random pet name for memorability.
resource "random_pet" "project_prefix" {
  keepers = {
    suffix_id = random_id.project_suffix.id
  }
}

// Generate a random ID with 32 bits of randomness for uniqueness.
resource "random_id" "project_suffix" {
  byte_length = 4
}

// Build a prefix for our project ID. If you want a `custom_id` and don't want a prefix, leave `id_prefix` empty and set `random_prefix` to `'false'`.
data "null_data_source" "project_prefix" {
  inputs = {
    value = var.random_prefix ? random_pet.project_prefix.id : var.id_prefix
  }
}

// Build a random ID that is both memorable *and* unique.
data "null_data_source" "random_project_id" {
  inputs = {
    value = format(
      "%s-%s",
      data.null_data_source.project_prefix.outputs["value"],
      random_id.project_suffix.hex,
    )
  }
}

// Build a custom ID.
data "null_data_source" "custom_project_id" {
  inputs = {
    value = data.null_data_source.project_prefix.outputs["value"] == "" ? var.custom_id : format(
      "%s-%s",
      data.null_data_source.project_prefix.outputs["value"],
      var.custom_id,
    )
  }
}

// Return the correct project ID—a non-empty custom ID takes precedence.
data "null_data_source" "project_id" {
  inputs = {
    value = var.custom_id == "" ? data.null_data_source.random_project_id.outputs["value"] : data.null_data_source.custom_project_id.outputs["value"]
  }
}

// Random project name if one wasn't specified already.
data "null_data_source" "project_name" {
  inputs = {
    value = var.display_name == "" ? title(
      join(
        " ",
        slice(
          split("-", data.null_data_source.project_id.outputs["value"]),
          0,
          2,
        ),
      ),
    ) : var.display_name
  }
}

// Fetch information about the organization.
data "google_organization" "details" {
  organization = var.organization_id
}

// Fetch information about the project's default service account.
data "google_compute_default_service_account" "details" {
  project = google_project.project.id
}

