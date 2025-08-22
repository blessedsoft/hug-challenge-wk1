provider "netlify" {
  token = var.netlify_api_token
}

# No data source needed for personal site
# Terraform just manages the token & remote state
