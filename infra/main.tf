terraform {
  required_version = "~> 0.14.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.48.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

locals {
  origin_domain  = "sportport.net"
  routing_domain = "maho.sportport.net"
  s3_bucket_name = "maho-static-host"
}