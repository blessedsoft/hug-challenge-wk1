terraform {
  required_version = ">= 1.5.0"

  # Remote state in HCP Terraform (Terraform Cloud)
  cloud {
    organization = "My-Org"    # ← set your org name
    workspaces {
      name = "hug-challenge-wk1" # ← set your workspaces name
    }
  }

  required_providers {
    netlify = { source = "netlify/netlify", version = ">= 0.3.0" }
    random  = { source = "hashicorp/random",  version = ">= 3.5.0" }
  }
}
