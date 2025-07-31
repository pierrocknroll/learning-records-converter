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
  project_id = var.scaleway_project_id
  region     = var.scaleway_region
  zone       = var.scaleway_zone
}

provider "aws" {
  region = var.aws_region
}
