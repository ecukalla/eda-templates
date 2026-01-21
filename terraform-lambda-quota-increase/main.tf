terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28.0"
    }
  }

  required_version = ">= 1.14.3"
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

# Module calls for each region.
# Terraform does not currently support dynamic provider assignment in for_each loops,
# so each region must be explicitly defined here to use its respective regional provider.

moved {
  from = aws_servicequotas_service_quota.lambda_concurrency_exec
  to   = module.quota_increase_us_east_1.aws_servicequotas_service_quota.this
}

module "quota_increase_us_east_1" {
  source      = "./modules/lambda-quota-increase"
  quota_value = var.quota_value
  providers = {
    aws = aws.us_east_1
  }
}

module "quota_increase_us_east_2" {
  source      = "./modules/lambda-quota-increase"
  quota_value = var.quota_value
  providers = {
    aws = aws.us_east_2
  }
}