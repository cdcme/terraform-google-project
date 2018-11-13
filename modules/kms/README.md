# GCP Cloud Key Management Service Module

More information about [Cloud Key Management Service](https://cloud.google.com/kms/).

## Inputs

| Name | Description | Type | Default |
|------|-------------|:----:|:-----:|
| create\_encryption\_resources | Whether or not to create GCP KMS resources. | string | - |
| project\_id | The project ID. | string | - |
| region | The preferred region to use for resources that require a region to be defined. | string | - |
| service\_account\_email | The email address of the project SA to grant access to encryption resources. | string | - |
| kms\_crypto\_key\_roles | - | list | `[ "roles/cloudkms.cryptoKeyEncrypterDecrypter" ]` |
| rotation\_period | Generate a new CryptoKeyVersion and set it as the primary this often. | string | `604800s` |

## Outputs

| Name | Description |
|------|-------------|
| key\_keyring | - |
| key\_name | - |
| key\_rotation\_period | - |
| key\_self\_link | - |
| keyring\_location | - |
| keyring\_name | - |
| keyring\_project | - |
| keyring\_self\_link | - |



