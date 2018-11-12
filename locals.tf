locals {
  project_id   = "${data.null_data_source.project_id.outputs["value"]}"
  project_name = "${data.null_data_source.project_name.outputs["value"]}"
}
