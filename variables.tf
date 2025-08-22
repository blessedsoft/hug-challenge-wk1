variable "netlify_api_token" {
  description = "Netlify API token (keep this secret)"
  type        = string
  sensitive   = true
}

variable "site_name" {
  description = "Netlify site subdomain"
  type        = string
  default     = "hug-fashion"  # Change to match your Netlify site
}
