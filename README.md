# A beginner-friendly guide to implement this project **(HUG-Challenge-Week-1)**

**Olajide Salami**  ∙  **August 22, 2025**  ∙  5 **min read**  ∙  *View on Notion*

---

## 🔎 What you’ll build

- A minimal static website served on **Netlify**.
- Infrastructure managed by **Terraform**.
- **Remote state** stored in **HCP Terraform (Terraform Cloud)**.
- A reproducible workflow your teammates can run on any machine.

---

## ✅ Prerequisites

- [ ]  **Terraform** v1.5+ installed (Windows/macOS/Linux)  
- [ ]  **HCP Terraform** (Terraform Cloud) account + **Organization**  
- [ ]  Terraform Cloud **Workspace** (e.g., `hug-challenge-wk1`)  
- [ ]  **Netlify** account + **Personal Access Token (PAT)`  
- [ ]  **GitHub** account + an empty repo for this project  

> Tip: Keep a browser tab open for Netlify and one for Terraform Cloud while following this guide.

---

## 🗺️ Architecture at a glance

- You commit site code + Terraform files to **GitHub**.  
- Terraform runs with **remote state** in **HCP Terraform**.  
- Terraform creates/configures a **Netlify** site connected to your repo.  
- Netlify serves the content in your repo’s `site/` folder.  

![Architecture Diagram](architecture.png)

---

## 📁 Project structure
hug-challenge-wk1/
├── site/
│ ├── index.html
│ ├── style.css (optional)
│ ├── images/ (optional)
│ ├── js/ (optional)
│ └── css/ (optional)
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── providers.tf
├── .gitignore
└── README.md


---

## 🧰 Step 1: Install Terraform (once)

**macOS (Homebrew):**

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -v


Windows (PowerShell + Chocolatey):

choco install terraform
terraform -v


Ubuntu/Debian:

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
terraform -v

🧱 Step 2: Create accounts & tokens

Netlify → Create a Personal Access Token (PAT).

Add to Terraform Cloud Workspace → Variables as:

Key: NETLIFY_TOKEN

Value: your token

Sensitive: ✅

HCP Terraform (Terraform Cloud) → Make sure you have:

An Organization (e.g., My-Org)

A Workspace (e.g., hug-challenge-wk1)

🗃️ Step 3: Create the repo & files

Make a public GitHub repo, e.g. https://github.com/blessedsoft/hug-challenge-wk1.git

Clone locally and add the files below.

.gitignore
# Terraform
.terraform/
.terraform.lock.hcl
terraform.tfstate
terraform.tfstate.backup
crash.log

# Local
.DS_Store
.env

site/index.html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>HUG Challenge Week 1: Deployed with Terraform ✨ Netlify ✨ HCP</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>body{font:16px/1.5 system-ui;margin:2rem;max-width:48rem}</style>
  </head>
  <body>
    <h1>It works! 🎉</h1>
    <p>This site was deployed to Netlify via Terraform with remote state in HCP Terraform.</p>
    <p>Edit <code>site/index.html</code>, commit, and re-apply to see changes.</p>
  </body>
</html>

versions.tf
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = "0.2.3"
    }
  }

  cloud {
    organization = "My-Org" # Your Terraform Cloud org
    workspaces {
      name = "hug-challenge-wk1" # Your workspace
    }
  }
}

variables.tf
variable "site_name" {
  description = "Netlify site subdomain"
  type        = string
  default     = "hug-challenge-wk1"
}

main.tf
provider "netlify" {
  # token comes from NETLIFY_TOKEN env var
}

outputs.tf
output "site_url" {
  description = "The live URL of the Netlify site"
  value       = "https://${var.site_name}.netlify.app"
}

output "site_id" {
  description = "The Netlify site identifier"
  value       = var.site_name
}


Commit & push:

git add .
git commit -m "Initial project setup with Terraform + Netlify"
git push origin main

☁️ Step 4: Configure Terraform Cloud workspace

Open Terraform Cloud → Org → Workspace → Variables

Add Environment variable:

Key: NETLIFY_TOKEN
Value: <your PAT>
Sensitive: true

🏃 Step 5: Run Terraform

Authenticate once:

terraform login


Initialize:

terraform init -upgrade


Plan:

terraform plan


Apply:

terraform apply


Take a screenshot of successful apply ✅

🌐 Step 6: Verify Netlify

Go to Netlify → Sites → hug-challenge-wk1 → Settings → Build & deploy:

Branch: main

Base directory: site

Publish directory: site

Push a change to site/index.html → Netlify will auto-deploy 🚀

🧹 Step 7: Clean up
terraform destroy

🧩 Troubleshooting

Netlify 404? → Ensure site/index.html exists and repo is connected.

Missing NETLIFY_TOKEN? → Add it as env var in Terraform Cloud.

Workspace mismatch? → Fix organization + workspace names in versions.tf.

📚 Quick reference
terraform login
terraform init -upgrade
terraform plan
terraform apply
terraform destroy


✅ Done! Your site is live via Netlify, managed with Terraform, and state stored in HCP Terraform.


Would you like me to also **add the screenshot placeholders** (like `![terraform-apply.png]`) into this markdown so you can just drop your actual screenshots into the repo later?
