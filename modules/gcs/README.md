# GCS Bucket Module

More information about [Cloud Storage](https://cloud.google.com/storage/).

## Inputs

| Name | Description | Type | Default |
|------|-------------|:----:|:-----:|
| default\_kms\_key\_name | The KMS key name to use for encryption/decryption of project storage objects. | string | - |
| project\_id | The project ID. | string | - |
| service\_account\_email | The email address of the project SA to grant access to storage resources. | string | - |
| create\_project\_bucket | Whether or not to create a GCS bucket for this project. If `'true'`, a logging bucket will automatically be created and logging will be enabled. If `configure_kms` is `'true`, any buckets created will be configured with encryption enabled using your project's KMS key. | string | `true` |
| location | The location to create your project's storage resources in | string | `US` |
| name\_prefix | A prefix for your bucket names (not a storage prefix path). | string | `` |
| storage\_class | The storage class for your bucket. | string | `MULTIREGIONAL` |

## Outputs

| Name | Description |
|------|-------------|
| logging\_bucket\_name | - |
| logging\_bucket\_self\_link | - |
| logging\_bucket\_url | - |
| store\_bucket\_name | - |
| store\_bucket\_self\_link | - |
| store\_bucket\_url | - |


