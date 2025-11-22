terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
    github = {
      source = "integrations/github"
      version = "6.8.3"
    }
  }
}

# API keys are automatically loaded from shared credentials file
# Use AWS CLI to login locally
provider "aws" {
  region = "ca-central-1"

  default_tags {
    tags = {
      Created-By = "terraform-backend-bootstrap"
    }
  }
}

provider "github" {

}
