terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28.0"
    }
  }
}

variable "quota_value" {
  description = "The new quota value for Lambda concurrent executions"
  type        = number
}

resource "aws_servicequotas_service_quota" "this" {
  quota_code   = "L-B99A9384"
  service_code = "lambda"
  value        = var.quota_value
}
