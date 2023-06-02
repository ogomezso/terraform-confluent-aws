variable "confluent_cloud_api_key" {
  type        = string
  description = "Confluent Cloud API KEY. export TF_VAR_confluent_cloud_api_key=\"API_KEY\""
}

variable "confluent_cloud_api_secret" {
  type        = string
  description = "Confluent Cloud API KEY. export TF_VAR_confluent_cloud_api_secret=\"API_SECRET\""
}

variable "confluent_env_name" {
  type = string
  description = "Confluent Cloud Environment Name"
}

variable "region" {
  type = string
  description = "AWS Region"
}

variable "confluent_env_sr_package" {
  type = string
  description = "Confluent Schema Registry Package"
}

variable "confluent_network_display_name" {
  type = string
  description = "Confluent Network display name"
  default = ""
}

variable "confluent_network_connection_type" {
  type = string
  description = "Confluent Network connection type (TRANSITGATEWAY, PRIVATELINK, PEERING)"
  default = ""
}

variable "confluent_network_cidr" {
  type = string
  description = "Confluent Network cidr block"
  default = ""
}

variable "aws_prefix" {
  type = string
  default = "cflt"
  description = "Prefix for AWS resources (default cflt)"
}

variable "aws_owner" {
  type = string
  default = ""
  description = "AWS Owner mail (default empty)"
}

variable "aws_vpc_public_subnets" {
  type = number
  default = 1
  description = "Number of public subnets for AWS VPC (default = 1)"
}

variable "aws_vpc_private_subnets" {
  type = number
  default = 1
  description = "Number of private subnets for AWS VPC (default = 1)"
}

variable "aws_bastion_name" {
  type = string
  default = "cflt_bastion"
  description = "AWS Client VPC Bastion Machine Name (default = cflt_bastion)"
}

variable "aws_bastion_type" {
  type = string
  default = "t2.micro"
  description = "AWS Client VPC Bastion machine instance type (default = t2.micro)"
}

variable "aws_kms_key_alias" {
  type = string
  default = "cflt_byok_key"
  description = "AWS KMS Key Alias"
}

variable "aws_kms_key_description" {
  type = string
  default = "Confluent BYOK key"
  description = "AWS KMS Key decription"
}

# Confluent Cloud Service Account  
variable "confluent_service_account" {
  description = "Service Account and Role for Confluent Cloud cluster management."
  type = object({
    name = string
    role = string
  })
}

# Cluster definition
variable "confluent_cluster" {
  description = "Confluent Cloud Cluster Configuration"
  type = object({
    display_name = string
    availability = string
    cloud        = string
    region       = string
    type         = string
    cku          = optional(string)
    config       = optional(map(string))
  })
  validation {
    condition = (
      contains(["SINGLE_ZONE", "MULTI_ZONE"], var.confluent_cluster.availability)
      && contains(["GCP", "AWS", "AZURE"], var.confluent_cluster.cloud)
      && contains(["BASIC", "STANDARD", "DEDICATED"], var.confluent_cluster.type)
      && (var.confluent_cluster.type == "DEDICATED" ? var.confluent_cluster.type == "DEDICATED" && var.confluent_cluster.cku != null : true)
    )
    error_message = <<EOT
- cluster.availability => SINGLE_ZONE or MULTI_ZONE 
- cluster.cloud => GCP, AWS or AZURE 
- cluster.type => BASIC or STANDARD or DEDICATED
- for DEDICATED clusters, cluster.cku must be set
    EOT
  }
}
