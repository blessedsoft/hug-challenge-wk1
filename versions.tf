terraform {
  required_version = ">= 1.5.0"

  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = "0.2.3"
    }
  }

  cloud {
    organization = "Media-Fi-Digitals"  # Your Terraform Cloud org
    workspaces {
      name = "my-static-website"   # Your Terraform Cloud workspace
    }
  }
}
