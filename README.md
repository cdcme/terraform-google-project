# Terraform Google Project

A Terraform Module that helps you create projects for Google Cloud Platform.

## Goals

#### Include batteries, _and_ be minimal

Make it easy to create a GCP project with network topology and security best practices provided by default, while _not_ adding anything that isn't strictly necessary

#### Play nice with others

Avoid hiding inputs or outputs, except where it makes sense to do so, and use naming conventions and descriptions from provider documentation

#### Give people options

Provide a modular design, so people can use what they want and ignore what they don't

#### Make it easy to use

Follow HashCorps's [standards for module design](https://www.terraform.io/docs/modules/create.html#standard-module-structure) and the examples set in modules like [hashicorp/terraform-consul](https://github.com/hashicorp/terraform-google-consul)

#### Create a good developer experience

Use [HCL](https://github.com/hashicorp/hcl) and Terraform as idiomatically as possible, including:

- [putting implicit dependencies first](https://www.terraform.io/intro/getting-started/dependencies.html#implicit-and-explicit-dependencies)
- [avoiding using the external provider](https://www.terraform.io/docs/providers/external/data_source.html)
- only creating dependencies on external scripts or tools if absolutely necessary
- not making assumptions about environments or relying on idiosyncratic environment configuration
- etc.

## Features

By default, the module creates the following regional resources:

- a GCP project with a randomized but memorable project ID and name
- a new project service account, replacing the default account
- a Terraform state bucket in the host project for the project's state
- a KMS keyring and encryption key for asymmetric encryption/decryption
- a GCS bucket for logging access to the project storage bucket, with encryption enabled using the project's KMS key
- a GCS bucket for project-wide storage of sensitive objects, with encryption enabled using the project's KMS key
- a VPC network configured as a service network on the Shared VPC host network
- a default firewall rule blocking SSH from anywhere but inside of GCP Cloud Console

_Only_ the GCP project itself and the service account are required. Everything else is optional and configurable.

## Inputs

| Name | Description | Type | Default |
|------|-------------|:----:|:-----:|
| billing\_account | The billing account ID to enable for this project. | string | - |
| host\_project | The project ID of the GCP project used by Terraform to create this project. | string | - |
| organization\_id | The ID of your organization in GCP Cloud Console. | string | - |
| auto\_create\_network | Create the 'default' network automatically. | string | `false` |
| create\_encryption\_resources | Whether or not to create GCP KMS resources. If `'true'`, all encrypted resources will use the customer-managed key. | string | `true` |
| create\_project\_bucket | Whether or not to create a GCS bucket for this project. If `'true'`, a logging bucket will automatically be created and logging will be enabled. If `configure_kms` is `'true`, any buckets created will be configured with encryption enabled using your project's KMS key. | string | `true` |
| create\_tfstate\_bucket | Whether or not to create a bucket for Terraform state in your `host_project`, if defined. | string | `true` |
| create\_usage\_reporting\_bucket | Whether or not to create a bucket for your project's GCE usage reporting. | string | `false` |
| custom\_id | Custom project ID if not using `random_id`. Either `custom_id` must be specified or `random_id` must be true. | string | `` |
| display\_name | The name that will be displayed in GCP Cloud Console's interface. | string | `` |
| enable\_apis | Which APIs to enable for this project. | list | `[ "compute.googleapis.com", "cloudbilling.googleapis.com" ]` |
| folder\_id | A folder to create this project under. If none is provided, the project will be created under the organization. | string | `` |
| gcloud\_credentials | Path to the service account credentials used by the Terraform host project. | string | `~/.config/gcloud/credentials.json` |
| id\_prefix | A prefix to use with your `custom_id` or `random_id`. | string | `` |
| labels | A set of key/value label pairs to assign to the project. | map | `{ "environment": "development" }` |
| project\_storage\_class | The storage class to use for your project's storage and logging buckets. | string | `REGIONAL` |
| random\_id | Whether or not to generate a random project ID. Either `custom_id` must be specified or `random_id` must be true. | string | `true` |
| random\_prefix | Whether or not to generate a random prefix for your project ID. If you want to use a `custom_id` and don't want a prefix, set this to `'false'` and don't set a value for `id_prefix`. | string | `true` |
| region | The preferred region to use for resources that require a region to be defined. | string | `us-central1` |
| skip\_delete | If true, the Terraform resource can be deleted without deleting the Project via the Google API. | string | `false` |
| tfstate\_storage\_class | The storage class to use for your Terraform state bucket. | string | `REGIONAL` |

## Outputs

| Name | Description |
|------|-------------|
| id | The project ID. |
| kms | [Project KMS resource details](https://github.com/minnowpod/terraform-google-project/tree/master/modules/kms/README.md). |
| labels | A set of key/value label pairs to assign to the project. |
| name | The display name of the project. |
| number | The numeric identifier of the project. |
| service\_account | Project default service account details. |
| storage | Project GCS bucket details. |
| tfstate\_bucket | [Project Terraform state bucket details.](https://github.com/minnowpod/terraform-google-project/tree/master/modules/gcs/README.md) |

Check `_docs/graph.png` for the Terraform graph.

## Usage

```shell
# TODO
```

See also the included [examples](https://github.com/minnowpod/terraform-google-project/tree/master/examples).

## Who maintains this Module?

This Module is maintained by [Minnow](https://minnow.me/), an IoT startup that makes smart food pickup kiosks called pods.

## How do I contribute?

Contributions are welcome! Check out [CONTRIBUTING](https://github.com/minnowpod/terraform-google-project/tree/master/CONTRIBUTING.md) for instructions.

## How is this Module versioned?

This Module follows the principles of [Semantic Versioning](http://semver.org/). You can find each new release,
along with the changelog, in the [CHANGELOG](https://github.com/minnowpod/terraform-google-project/tree/master/CHANGELOG.md).

During initial development, the major version will be 0 (e.g., `0.x.y`), which indicates the code does not yet have a
stable API. Once we hit `1.0.0`, we will make every effort to maintain a backwards compatible API and use the MAJOR,
MINOR, and PATCH versions on each release to indicate any incompatibilities.

## License

This code is released under the MIT License. Please see [LICENSE](https://github.com/minnowpod/terraform-google-project/tree/master/LICENSE) for more details.

