provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      env = "maho"
    }
  }
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

terraform {
  required_version = "~> 0.14.8"
/*
    backend "s3" {
        backet =
        region =
        key =
        encrypt =
    }
*/
}

locals {
  s3_bucket_name = "maho_static_site"
  domain         = "maho.	sportport.net"
}

module "spa_infra" {
  providers = {
    aws = aws.east
  }

  source = "./module/spa_infra"

  domain         = local.domain
  s3_bucket_name = local.s3_bucket_name
}