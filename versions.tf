terraform {
  required_version = ">= 1.5.0"

  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = "0.2.3"
    }
  }

  cloud {
    organization = "hug-fashion-web"  # Your Terraform Cloud org
    workspaces {
      name = "hug-fashion-websites"   # Your Terraform Cloud workspace
    }
  }
}
