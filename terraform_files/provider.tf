terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.1"
    }
    github = {
      source = "integrations/github"
      version = "5.39.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
//  access_key = ""
//  secret_key = ""
}
provider "github" {
  token = var.git-token
  }