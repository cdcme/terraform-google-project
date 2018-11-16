# Shared VPC Module

More information about [Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc).

## Inputs

| Name | Description | Type | Default |
|------|-------------|:----:|:-----:|
| host\_project | The project ID of the GCP project used by Terraform to create this project. | string | - |
| project\_id | The project ID. | string | - |
| service\_account\_email | The email address of the project SA to grant access to networking resources. | string | - |
| services | Only used to ensure that API services are enabled before creating VPC resources. | string | - |
| auto\_create\_subnets | Whether or not to automatically create subnets on this VPC. | string | `false` |
| create\_ssh\_fw\_rule | If true, this will create a firewall rule preventing SSH access from anywhere but within Cloud Console. | string | `true` |
| create\_vpc\_network | Whether or not to create a VPC network for the project. If `'true'`, this will try to configure this project as a service project on the host project's VPC network's shared subnet. | string | `true` |
| flow\_logs | Whether to enable flow logging for the Shared VPC subnetwork. | string | `true` |
| fw\_rule\_name | A name for the SSH firewall rule. One will be generated based on your `project_id` if you leave this blank. | string | `` |
| host\_dns\_zone | The VPC host network's managed DNS zone. | string | `` |
| network\_name | A unique name for the VPC network, required by GCE. | string | `` |
| private\_access | Whether to allow private access to Google APIs without an external IP address. | string | `true` |
| region | The preferred region to use for resources that require a region to be defined. | string | `us-central1` |
| routing\_mode | Sets the network-wide routing mode for Cloud Routers to use. Accepted values are 'GLOBAL' or 'REGIONAL'. | string | `REGIONAL` |
| subnet\_name | The name of the resource, provided by the client when initially creating the resource. The name must be 1-63 characters long, and comply with RFC1035. | string | `` |

## Outputs

| Name | Description |
|------|-------------|
| auto\_create\_subnetworks | Whether or not subnets will be (in plan) or were (in apply) automatically created on this VPC. |
| flow\_logs | Whether you have enabled flow logging for the Shared VPC subnetwork. |
| gateway\_ipv4 | The IPv4 address of the gateway. |
| ips | The VPC subnets IP range in CIDR format. |
| name | The unique name for the VPC network, required by GCE. |
| private\_access | Whether you have allowed private access to Google APIs without an external IP address. |
| routing\_mode | The network-wide routing mode for Cloud Routers.. |
| self\_link | The URI of the created resource. |
| subnets | The VPC subnets that will be (in plan) or were (in apply) created. |



