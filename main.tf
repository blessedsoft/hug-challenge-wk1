# Unique suffix so your Netlify subdomain doesn’t clash
resource "random_pet" "suffix" {
  length = 2
}

# Deploy key lets Netlify clone your GitHub repo (needed for private repos; fine for public too)
resource "netlify_deploy_key" "this" {}

# Create the Netlify site and connect it to your GitHub repo
resource "netlify_site" "this" {
  name = coalesce(var.site_name, "hug-challenge-wk1-${random_pet.suffix.id}")

  repo {
    provider      = "github"
    repo_path     = var.repo_path       # e.g., "My-Org/hug-challenge-wk1"
    repo_branch   = var.repo_branch
    dir           = var.publish_dir     # e.g., "site"
    command       = var.build_command   # empty means no build step
    deploy_key_id = netlify_deploy_key.this.id
  }
}

# (Optional) If you want site-level env vars, uncomment below:
# data "netlify_team" "team" {
#   slug = var.team_slug
# }
# resource "netlify_environment_variable" "greeting" {
#   team_id = data.netlify_team.team.id
#   site_id = netlify_site.this.id
#   key     = "GREETING"
#   values = [{ value = "Hello from Terraform!", context = "all" }]
# }
