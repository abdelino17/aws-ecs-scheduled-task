locals {
  default_tags = {
    application = var.application_name
    environment = var.environment
    team        = var.team
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = local.default_tags
  }
}
