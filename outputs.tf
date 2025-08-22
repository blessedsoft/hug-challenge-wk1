output "site_url" {
  description = "The live URL of the Netlify site"
  value       = "https://${var.site_name}.netlify.app"
}

output "site_id" {
  description = "The Netlify site identifier"
  value       = var.site_name
}
