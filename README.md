**Deploying a Static Site to Netlify with Terraform + HCP Remote State**————————————————————————————————————

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

<img width="1536" height="1024" alt="ChatGPT Image Aug 22, 2025, 01_54_17 PM" src="https://github.com/user-attachments/assets/0831b8c6-1d2c-4663-a903-21b2ae91aa54" />    

📁 Project structure
--------------------

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


📁 Project Documentation
--------------------

Kindly check the documentation here: https://www.notion.so/How-to-Deploy-a-Static-Site-to-Netlify-with-Terraform-HCP-Remote-State-25773770dae980219202e7a635965055?source=copy_link


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
