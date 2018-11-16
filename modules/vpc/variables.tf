/**
* REQUIRED PARAMETERS
* These parameters must be supplied when consuming this module.
*/

variable "host_project" {
  description = "The project ID of the GCP project used by Terraform to create this project."
}

variable "project_id" {
  description = "The project ID."
}

variable "service_account_email" {
  description = "The email address of the project SA to grant access to networking resources."
}

variable "services" {
  description = "Only used to ensure that API services are enabled before creating VPC resources."
}

/**
* OPTIONAL PARAMETERS
* These parameters have reasonable defaults.
*/

variable "auto_create_subnets" {
  description = "Whether or not to automatically create subnets on this VPC."
  default     = "false"
}

variable "create_vpc_network" {
  description = "Whether or not to create a VPC network for the project. If `'true'`, this will try to configure this project as a service project on the host project's VPC network's shared subnet."
  default     = "true"
}

variable "network_name" {
  description = "A unique name for the VPC network, required by GCE."
  default     = ""
}

variable "region" {
  description = "The preferred region to use for resources that require a region to be defined."
  default     = "us-central1"
}

variable "routing_mode" {
  description = "Sets the network-wide routing mode for Cloud Routers to use. Accepted values are 'GLOBAL' or 'REGIONAL'."
  default     = "REGIONAL"
}

variable "host_dns_zone" {
  description = "The VPC host network's managed DNS zone."
  default     = ""
}

variable "create_ssh_fw_rule" {
  description = "If true, this will create a firewall rule preventing SSH access from anywhere but within Cloud Console."
  default     = "true"
}

variable "fw_rule_name" {
  description = "A name for the SSH firewall rule. One will be generated based on your `project_id` if you leave this blank."
  default     = ""
}

variable "flow_logs" {
  description = "Whether to enable flow logging for the Shared VPC subnetwork."
  default     = "true"
}

variable "private_access" {
  description = "Whether to allow private access to Google APIs without an external IP address."
  default     = "true"
}

variable "subnet_name" {
  description = "The name of the resource, provided by the client when initially creating the resource. The name must be 1-63 characters long, and comply with RFC1035."
  default     = ""
}
