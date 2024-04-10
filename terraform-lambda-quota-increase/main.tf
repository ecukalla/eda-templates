terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }

  required_version = ">= 1.7.5"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_servicequotas_service_quota" "lambda_concurrency_exec" {
  quota_code   = "L-B99A9384"
  service_code = "lambda"
  value        = 1000
}