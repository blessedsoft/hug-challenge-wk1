variable "team_slug" {
  description = "Your Netlify team slug (Settings → Team information)"
  type        = string
}

variable "repo_path" {
  description = "GitHub org/repo (e.g., My-Org/hug-challenge-wk1)"
  type        = string
}

variable "repo_branch" {
  description = "Branch to build"
  type        = string
  default     = "main"
}

variable "publish_dir" {
  description = "Folder (relative to repo root) that Netlify should publish"
  type        = string
  default     = "site"
}

variable "build_command" {
  description = "Optional build command (leave empty for static HTML)"
  type        = string
  default     = ""
}

variable "site_name" {
  description = "Optional override for site name (otherwise random suffix used)"
  type        = string
  default     = null
}