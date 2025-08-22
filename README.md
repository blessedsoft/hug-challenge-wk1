**Deploying a Static Site to Netlify with Terraform + HCP Remote State** 

🔎 What you’ll build
--------------------

*   A minimal static website served on **Netlify**.
    
*   Infrastructure managed by **Terraform**.
    
*   **Remote state** stored in **HCP Terraform (Terraform Cloud)**.
    
*   A reproducible workflow your teammates can run on any machine.
    

✅ Prerequisites
---------------

*   \[ \] **Terraform** v1.5+ installed (Windows/macOS/Linux)
    
*   \[ \] **HCP Terraform** (Terraform Cloud) account + **Organization**
    
*   \[ \] Terraform Cloud **Workspace** (e.g., hug-challenge-wk1)
    
*   \[ \] **Netlify** account + **Personal Access Token (PAT)**
    
*   \[ \] **GitHub** account + an empty repo for this project
    

> Tip: Keep a browser tab open for Netlify and one for Terraform Cloud while following this guide.

🗺️ Architecture at a glance
----------------------------

*   You commit site code + Terraform files to **GitHub**.
    
*   Terraform runs with **remote state** in **HCP Terraform**.
    
*   Terraform creates/configures a **Netlify** site connected to your repo.
    
*   Netlify serves the content in your repo’s site/ folder.
    

📁 Project structure
--------------------

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   hug-challenge-wk1/  ├── site/  │   ├── index.html  │   ├── style.css (optional)  │   ├── images/   (optional)  │   ├── js/       (optional)  │   └── css/      (optional)  ├── main.tf  ├── variables.tf  ├── outputs.tf  ├── versions.tf  ├── providers.tf  ├── .gitignore  └── README.md (optional)   `

🧰 Step 1: Install Terraform (once)
-----------------------------------

*   brew tap hashicorp/tapbrew install hashicorp/tap/terraformterraform -v
    
*   choco install terraformterraform -v
    
*   sudo apt-get update && sudo apt-get install -y gnupg software-properties-commonwget -O- | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/nullecho "deb \[signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg\] $(lsb\_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.listsudo apt update && sudo apt install -y terraformterraform -v
    

🧱 Step 2: Create accounts & tokens
-----------------------------------

1.  **Netlify** → Create a **Personal Access Token** (PAT).
    
    *   Copy the PAT. You’ll use it once in Terraform Cloud as an **Environment Variable** called NETLIFY\_TOKEN.
        
2.  **HCP Terraform** (Terraform Cloud) → Make sure you have:
    
    *   An **Organization** (e.g., My-Org).
        
    *   A **Workspace** (e.g., hug-challenge-wk1).
        

> Please note that the Netlify provider reads the token from NETLIFY\_TOKEN (exact spelling). Do NOT name it netlify\_api\_token.

🗃️ Step 3: Create the repo & files
-----------------------------------

Create a new **public** GitHub repo e.g. [https://github.com/blessedsoft/hug-challenge-wk1.git](https://github.com/blessedsoft/hug-challenge-wk1.git) (private also works; see the Deploy Key note in Step 8).

Clone it locally and add the files below.

### .gitignore

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   # Terraform  .terraform/  .terraform.lock.hcl  terraform.tfstate  terraform.tfstate.backup  crash.log  override.tf  override.tf.json  *_override.tf  *_override.tf.json  # OS / local  .DS_Store  .env   `

### site/index.html

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML          ``HUG Challenge Week 1: Deployed with Terraform ✨ Netlify ✨ HCP            body{font:16px/1.5 system-ui;margin:2rem;max-width:48rem}        It works! 🎉 ============        This site was deployed to Netlify via Terraform with remote state in HCP Terraform.        Edit `site/index.html`, commit, and re-apply to see changes.``  

### versions.tf

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   terraform {    required_version = ">= 1.5.0"    required_providers {      netlify = {        source  = "netlify/netlify"        version = "0.2.3"      }    }    cloud {      organization = "My-Org"  # Your Terraform Cloud org      workspaces {        name = "my-static-website"   # Your Terraform Cloud workspace      }    }  }   `

### variables.tf

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   variable "site_name" {    description = "Netlify site subdomain"    type        = string    default     = "hug-challenge-wk1"  # Change to match your Netlify site  }   `

### main.tf

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   provider "netlify" {  #  token = var.netlify_api_token  }   `

### outputs.tf

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   output "site_url" {    description = "The live URL of the Netlify site"    value       = "{var.site_name}.netlify.app"  }  output "site_id" {    description = "The Netlify site identifier"    value       = var.site_name  }   `

Commit & push:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   git add .  git commit -m "My static website using Terraform + Netlify project"  git push origin main   `

☁️ Step 4: Configure the Terraform Cloud workspace
--------------------------------------------------

Open **Terraform Cloud → Organization: Media-Fi-Digitals → Workspace: hug-challenge-wk1** (or your chosen name) → **Variables**.

### Environment Variables (used by the Netlify provider)

*   **Key:** NETLIFY\_TOKEN → **Value:** _your Netlify PAT_ → **Sensitive:** ON
    

> Do not store the token as a Terraform variable. Keep it as an environment variable (NETLIFY\_TOKEN).

🏃 Step 5: Run Terraform (CLI‑driven remote run)
------------------------------------------------

This style runs the plan/apply in Terraform Cloud but streams logs to your terminal. Perfect for collaboration + screenshots.

From your project root (where the .tf files live):

1.  Authenticate the CLI with Terraform Cloud (one time):
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   terraform login   `

1.  Initialize:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   terraform init -upgrade   `

1.  Plan:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   # If you set Terraform variables in the workspace, this is enough:  terraform plan  # Otherwise pass them explicitly:  # terraform plan \\  #   -var team_slug="YOUR_TEAM_SLUG" \\  #   -var repo_path="My-Org/Hug-challenge-wk1"   `

1.  Apply:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   terraform apply   `

During the run you’ll see a link to the live run page in Terraform Cloud. **Take a screenshot of the successful apply** for the challenge deliverable.

> **Private repo?** Copy the deploy\_key\_public output and add it to GitHub → Repo → Settings → Deploy keys → Add deploy key (read‑only). Then push any commit to main to trigger Netlify’s first build.

🌐 Step 6: Verify Netlify settings (first deploy)
-------------------------------------------------

Open **Netlify → Sites → Your site (hug-challenge-wk1) → Site configuration → Build & deploy** and verify:

*   **Branch to deploy:** main
    
*   **Base directory:** site (so Netlify looks inside your site/ folder)
    
*   **Build command:** _(empty, because it’s static HTML/CSS)_
    
*   **Publish directory:** site (that’s where index.html lives)
    

> If you prefer using the UI first: you can set these fields when Netlify initially prompts you to “Deploy your project”. They match exactly what Terraform configured in the repo {} block.

Push a small change to site/index.html → Netlify will auto‑deploy → open your site\_url from Terraform outputs. 🎉

🧹 Step 7: Clean up (optional)
------------------------------

To remove all Netlify resources created by Terraform (but keep your repo):

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   terraform destroy   `

🧩 Troubleshooting
------------------

**Site shows Netlify 404 (Site not found):**

*   Terraform created the site, but Netlify hasn’t deployed content yet. Ensure your repo has site/index.html, the repo is reachable (Deploy Key added if private), and a commit has been pushed to main.
    

**Error: No value for required variable netlify\_api\_token:**

*   Remove that variable from your code. The provider uses NETTIFY\_TOKEN env var instead. Alternatively wire token = var.netlify\_api\_token in the provider and set it as a **Terraform** variable (less recommended).
    

**Reference to undeclared resource (e.g., netlify\_site.site):**

*   Match names exactly. If your resource is netlify\_site.this, reference netlify\_site.this.url in outputs.
    

**Workspace mismatch:**

*   Ensure versions.tf has your **exact** organization and workspace names.
    

**Local execution vs Remote runs:**

*   In **Local** execution mode, Terraform Cloud does **not** inject workspace env vars; set export NETLIFY\_TOKEN=... locally. In **Remote (CLI‑driven)** mode, workspace env vars are available to your runs.
    

📚 Quick reference commands
---------------------------

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   # Authenticate Terraform CLI with Terraform Cloud  terraform login  # Initialize providers & set up remote state linkage  terraform init -upgrade  # See the execution plan  terraform plan  # Create/update resources  terraform apply  # Remove resources  terraform destroy   `

> You’re done! Your team can clone, set NETLIFY\_TOKEN in the workspace, and run the same steps to reproduce the site anytime.
