# Terraform Confluent AWS Module

Terraform module that cover different scenarios for Confluent Cloud Cluster Creation on AWS

## TODO

- Make environment creation optional if not provided data resource to get the id from config
- Make byok and network modules optional

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0.1 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | >=1.42.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >=4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_confluent_network"></a> [aws\_confluent\_network](#module\_aws\_confluent\_network) | github.com/mcolomerc/terraform-confluent-aws-network | n/a |
| <a name="module_byok"></a> [byok](#module\_byok) | github.com/ogomezso/terraform-confluent-aws-byok | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | mcolomerc/terraform-confluent-kafka-cluster | n/a |
| <a name="module_environment"></a> [environment](#module\_environment) | github.com/ogomezso/terraform-confluent-environment | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_bastion_name"></a> [aws\_bastion\_name](#input\_aws\_bastion\_name) | AWS Client VPC Bastion Machine Name (default = cflt\_bastion) | `string` | `"cflt_bastion"` | no |
| <a name="input_aws_bastion_type"></a> [aws\_bastion\_type](#input\_aws\_bastion\_type) | AWS Client VPC Bastion machine instance type (default = t2.micro) | `string` | `"t2.micro"` | no |
| <a name="input_aws_kms_key_alias"></a> [aws\_kms\_key\_alias](#input\_aws\_kms\_key\_alias) | AWS KMS Key Alias | `string` | `"cflt_byok_key"` | no |
| <a name="input_aws_kms_key_description"></a> [aws\_kms\_key\_description](#input\_aws\_kms\_key\_description) | AWS KMS Key decription | `string` | `"Confluent BYOK key"` | no |
| <a name="input_aws_owner"></a> [aws\_owner](#input\_aws\_owner) | AWS Owner mail (default empty) | `string` | `""` | no |
| <a name="input_aws_prefix"></a> [aws\_prefix](#input\_aws\_prefix) | Prefix for AWS resources (default cflt) | `string` | `"cflt"` | no |
| <a name="input_aws_vpc_private_subnets"></a> [aws\_vpc\_private\_subnets](#input\_aws\_vpc\_private\_subnets) | Number of private subnets for AWS VPC (default = 1) | `number` | `1` | no |
| <a name="input_aws_vpc_public_subnets"></a> [aws\_vpc\_public\_subnets](#input\_aws\_vpc\_public\_subnets) | Number of public subnets for AWS VPC (default = 1) | `number` | `1` | no |
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API KEY. export TF\_VAR\_confluent\_cloud\_api\_key="API\_KEY" | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API KEY. export TF\_VAR\_confluent\_cloud\_api\_secret="API\_SECRET" | `string` | n/a | yes |
| <a name="input_confluent_cluster"></a> [confluent\_cluster](#input\_confluent\_cluster) | Confluent Cloud Cluster Configuration | <pre>object({<br>    display_name = string<br>    availability = string<br>    cloud        = string<br>    region       = string<br>    type         = string<br>    cku          = optional(string)<br>    config       = optional(map(string))<br>  })</pre> | n/a | yes |
| <a name="input_confluent_env_name"></a> [confluent\_env\_name](#input\_confluent\_env\_name) | Confluent Cloud Environment Name | `string` | n/a | yes |
| <a name="input_confluent_env_sr_package"></a> [confluent\_env\_sr\_package](#input\_confluent\_env\_sr\_package) | Confluent Schema Registry Package | `string` | n/a | yes |
| <a name="input_confluent_network_cidr"></a> [confluent\_network\_cidr](#input\_confluent\_network\_cidr) | Confluent Network cidr block | `string` | `""` | no |
| <a name="input_confluent_network_connection_type"></a> [confluent\_network\_connection\_type](#input\_confluent\_network\_connection\_type) | Confluent Network connection type (TRANSITGATEWAY, PRIVATELINK, PEERING) | `string` | `""` | no |
| <a name="input_confluent_network_display_name"></a> [confluent\_network\_display\_name](#input\_confluent\_network\_display\_name) | Confluent Network display name | `string` | `""` | no |
| <a name="input_confluent_service_account"></a> [confluent\_service\_account](#input\_confluent\_service\_account) | Service Account and Role for Confluent Cloud cluster management. | <pre>object({<br>    name = string<br>    role = string<br>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->