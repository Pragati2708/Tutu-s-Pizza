terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
}