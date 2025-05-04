# 🇧🇷 GCP Regional ALB w/ Brazilian Reward 🇧🇷

[![Infrastructure-as-Code](https://img.shields.io/badge/IaC-Terraform-blueviolet)](https://www.terraform.io/)
[![GCP](https://img.shields.io/badge/Cloud-Google%20Cloud-blue)](https://cloud.google.com/)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE)
[![Made with Bash](https://img.shields.io/badge/script-Bash-lightgrey)](./Brazil-Script.sh)

## 📖 Project Overview

This project provisions a **highly available, regionally scoped HTTP Application Load Balancer on Google Cloud Platform** using Terraform and automates the configuration of a backend Brazil script web server using a **custom bash script**. The final product showcases not only your infrastructure skills, but also celebrates the culture of Brazil—complete with a Brazilian flag background and a dancing GIF.

---

## 🎯 Key Features

- ✅ Custom VPC and subnets per region
- ✅ NAT Gateway for outbound access
- ✅ Firewall rules based on target tags
- ✅ Managed Instance Group with Brazil script startup
- ✅ Global Load Balancer with regional backends
- ✅ Dynamic metadata-based Brazil script HTML
- ✅ Beautiful Brazilian dancer and flag in web background

---

## 📁 File Descriptions

| File | Description |
|------|-------------|
| `1-providers.tf` | Google Cloud provider and project configuration |
| `2-variables.tf` | Declares reusable input variables for regions, names, etc. |
| `3-vpc.tf` | Defines a custom VPC for all resources. |
| `4-subnets.tf` | Creates subnets in chosen regions with specific CIDR blocks. |
| `5-nat.tf` | Provisions Cloud NAT and router to enable outbound internet. |
| `6-firewall.tf` | Configures firewall rules based on tag-based traffic control. |
| `7-instance_template.tf` | Configures the Brazil web server via a startup script. |
| `8-instance_group.tf` | Creates a regional MIG (Managed Instance Group). |
| `9-load_balancer.tf` | Provisions HTTP(S) Load Balancer targeting MIGs. |
| `10-outputs.tf` | Displays the final load balancer IP and other outputs. |
| `Brazil-Script.sh` | Custom Bash startup script: that installs, sets metadata, and renders a custom HTML with GCP instance data and Brazilian theme. |

---

### 🖼️ Web Preview (Sample)

```html
<h1>I, TIQS, thank you, Sensei Theo and Lord Beron!</h1>
<p><b>Instance Name:</b> [hostname]</p>
<p><b>Internal IP:</b> [internal_ip]</p>
<p><b>Zone:</b> [zone]</p>
<img src="https://brazil-2025.s3.us-east-1.amazonaws.com/brazil5.gif">
```

### 🚀 Deployment Instructions

```bash
# Initialize, Format, Validate, Plan, and apply Terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
```

Wait for 2–3 minutes, then navigate to the load balancer's external IP to see your themed webpage.

---

### 🏁 Output Example

```bash
load_balancer_ip = "34.xxx.xxx.xxx"
```

---

## 🧹 Teardown Instructions

- ⚠️ Destroy all resources defined in the Terraform configuration

```bash
terraform destroy -auto-approve
```

- ⚠️ Warning: This will permanently delete your VPC, subnets, firewall rules, instance templates, managed instance groups, load balancer, and any associated IP addresses or metadata.

---

### 📌 Requirements

- Terraform 1.4+
- GCP Project with billing enabled
- Roles:
  - Compute Admin
  - Network Admin
  - Service Account User

---

### 🔧 Troubleshooting

- Here are some common issues and solutions when deploying this project:

#### 🛑 Problem: Load Balancer IP not responding

- Cause: Backend instances may not have completed startup or the health check may be failing.
- Solution:
  - Check if the Apache server is running on the VM: `gcloud compute ssh <instance-name> --zone <zone> --command="sudo systemctl status apache2"`

  - Verify health check and firewall ports `(tcp:80)` are allowed via 6-firewall.tf.

#### 🛑 Problem: Metadata not displaying on the webpage

- Cause: The metadata server might not be accessible from the script or Metadata-Flavor: Google header is missing.
- Solution: Ensure all curl requests in the `brazil-script.sh` include the correct header:

```bash
-H "Metadata-Flavor: Google"
```

#### 🛑 Problem: Apache not installed or service not starting

- Cause: Package manager may have failed or the script exited prematurely.
- Solution: SSH into a VM and run:

```bash
sudo apt update && sudo apt install apache2 -y
sudo systemctl enable apache2 && sudo systemctl start apache2
```

#### 🛑 Problem: Duplicate resource name error during terraform apply

- Cause: A resource block was reused or a name was declared twice.
- Solution:
  - Review each .tf file for duplicate resource name attributes or resource blocks.
  - Ensure variables `like name`, `instance_template`, or `forwarding_rule` are unique across files.

#### 🛑 Problem: Startup script not applied to instances

- Cause: The `metadata_startup_script` block in the `instance_template` may be misconfigured.
- Solution: Ensure the `brazil-script.sh` content is correctly referenced using the file() function:

```bash
metadata_startup_script = file("brazil-script.sh")
```
