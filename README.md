# A beginner-friendly guide implement this project  **(HUG-Challenge-Week-1)**

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
- [ ]  **Netlify** account + **Personal Access Token (PAT)**  
- [ ]  **GitHub** account + an empty repo for this project  

> 💡 Tip: Keep a browser tab open for Netlify and one for Terraform Cloud while following this guide.

---

## 🗺️ Architecture at a glance

- You commit site code + Terraform files to **GitHub**.  
- Terraform runs with **remote state** in **HCP Terraform**.  
- Terraform creates/configures a **Netlify** site connected to your repo.  
- Netlify serves the content in your repo’s `site/` folder.  

![Architecture Diagram](netlify-arch.png)

---

## 📁 Project structure
hug-challenge-wk1/
├── site/
│ ├── index.html
│ ├── css/
│ ├── fonts/
│ ├── images/ 
│ ├── js/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── providers.tf
├── Architechural_Diagram.png
├── .gitignore
└── README.md


---

## 🧰 Step 1: Install Terraform (once)

---

## 🧰 Step 1: Install Terraform (once)

- **macOS (Homebrew):**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -v
Windows (PowerShell + Chocolatey):

powershell
Copy
Edit
choco install terraform
terraform -v
Ubuntu/Debian:

bash
Copy
Edit
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
terraform -v
🧱 Step 2: Create accounts & tokens
Netlify → Create a Personal Access Token (PAT).

Copy the PAT. You’ll use it once in Terraform Cloud as an Environment Variable called NETLIFY_TOKEN.

HCP Terraform (Terraform Cloud) → Make sure you have:

An Organization (e.g., My-Org).

A Workspace (e.g., hug-challenge-wk1).

⚠️ The Netlify provider reads the token from NETLIFY_TOKEN (exact spelling). Do not name it netlify_api_token.

🗃️ Step 3: Create the repo & files
Create a new public GitHub repo (e.g. https://github.com/blessedsoft/hug-challenge-wk1).

Clone it locally and add the following files:

.gitignore

