output "site_name" {
  value       = netlify_site.this.name
  description = "Netlify site name (subdomain)"
}

output "site_url" {
  value       = netlify_site.this.url
  description = "Live Netlify site URL"
}

output "deploy_key_public" {
  value       = netlify_deploy_key.this.public_key
  description = "Public key for GitHub Deploy Keys (read-only)"
  sensitive   = true
}