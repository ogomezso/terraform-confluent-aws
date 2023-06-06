module "environment" {
  source                     = "github.com/ogomezso/terraform-confluent-environment"
  display_name               = var.confluent_env_name
  cloud_provider             = "AWS"
  region                     = var.region
  sr_package                 = var.confluent_env_sr_package
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "aws_confluent_network" {
  providers = {
    confluent = confluent.confluent_cloud
  }
  source = "github.com/mcolomerc/terraform-confluent-aws-network"
  #AWS
  aws = {
    region = var.region,
    prefix = var.aws_prefix,
    owner  = var.aws_owner,
    vpc = {
      number_of_public_subnets  = var.aws_vpc_public_subnets
      number_of_private_subnets = var.aws_vpc_private_subnets
    }
    instance = {
      name = var.aws_bastion_name
      type = var.aws_bastion_type
    }
  }

  # Confluent 
  environment = module.environment.env.id

  confluent_network = {
    display_name    = var.confluent_network_display_name
    connection_type = var.confluent_network_connection_type
    cidr            = var.confluent_network_cidr
  }

  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "byok" {
  providers = {
    confluent = confluent.confluent_cloud
  }
  source                     = "github.com/ogomezso/terraform-confluent-aws-byok"
  aws_region                 = var.region
  aws_kms_key_alias          = var.aws_kms_key_alias
  aws_kms_key_description    = var.aws_kms_key_description
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "cluster" {
  source                     = "mcolomerc/terraform-confluent-kafka-cluster"
  environment                = module.environment.env.id
  cluster                    = var.confluent_cluster
  network                    = module.aws_confluent_network.transit_gateay_confluent_network.id
  byok                       = module.byok.byok.id
  service_account            = var.confluent_service_account
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}
