terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.58"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.6"
    }
  }
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  project_id = var.scaleway_project_id
  region     = var.scaleway_region
  zone       = var.scaleway_zone
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
