# 🧭 USER GUIDE

## 🇧🇷 Step-by-Step: GCP Regional ALB w/ Brazilian Flair 🇧🇷

[![Infrastructure-as-Code](https://img.shields.io/badge/IaC-Terraform-blueviolet)](https://www.terraform.io/)
[![GCP](https://img.shields.io/badge/Cloud-Google%20Cloud-blue)](https://cloud.google.com/)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE)
[![Made with Bash](https://img.shields.io/badge/script-Bash-lightgrey)](./Brazil-Script.sh)

This guide walks you through building the same infrastructure configured in Terraform — **entirely via the GCP Console (ClickOps)**. You’ll deploy a regional HTTP Load Balancer with a Managed Instance Group (MIG), using a startup script to serve a custom Brazilian-themed webpage.

---

## 📌 Prerequisites

- GCP project with billing enabled
- Editor or Owner permissions
- IAM roles: Compute Admin, Network Admin, Load Balancer Admin
- Region to deploy: `southamerica-east1` (São Paulo)

---

## 🧱 Step 1: Create a Custom VPC Network

1. Navigate to **VPC network > VPC networks**.
2. Click **"Create VPC network"**.
3. Name it: `brazil-vpc`
4. Choose **"Custom"** subnet mode.
5. Add a subnet:
   - **Name**: `web-subnet`
   - **Region**: `southamerica-east1`
   - **IP range**: `10.233.10.0/24`
6. Leave all other defaults.
7. Click **"Create"**.

![vpc](/Screenshots/vpc.jpg)

---

## 🌐 Step 2: Configure Firewall Rules

1. Go to **VPC network > Firewall rules**.
2. Click **"Create firewall rule"**.
3. Name it: `allow-http`
4. **Network**: `brazil-vpc`
5. **Targets**: Specify target tags → `http-server`
6. **Source IP ranges**: `0.0.0.0/0`
7. **Protocols and ports**: Select "Specified protocols and ports" → TCP: `80`
8. Click **"Create"**.

![firewall](/Screenshots/firewall.jpg)

---

## 🖥️ Step 3: Create an Instance Template

1. Navigate to **Compute Engine > Instance templates**.
2. Click **"Create instance template"**.
3. Name it: `web-template`
4. **Machine type**: e2-micro
5. **Boot disk**: Debian GNU/Linux 11
6. **Network tags**: `brazil`
7. Expand **Advanced options > Automation > Startup script**
8. Paste the contents of `brazil-script.sh`
9. Click **"Create"**.

![instance-template](/Screenshots/instance-template.jpg)

---

## 👥 Step 4: Create a Managed Instance Group (MIG)

1. Go to **Compute Engine > Instance groups**.
2. Click **"Create instance group"**.
3. Choose **New managed instance group**.
4. Name: `web-mig`
5. Region: `southamerica-east1`
6. Instance template: `web-template`
7. Subnet: `web-subnet`
8. Initial size: 1 (can scale later)
9. Click **"Create"**.

![instance-group](/Screenshots/instance-group.jpg)

---

## 💓 Step 5: Create a Health Check

1. Navigate to **Network services > Health checks**.
2. Click **"Create a health check"**.
3. Name: `mig-health-check`
4. Protocol: **HTTP**
5. Port: **80**
6. Path: `/`
7. Click **"Create"**.

![health-checks](/Screenshots/health-checks.jpg)

---

## 🔁 Step 6: Create a Backend Service

1. Go to **Network services > Load balancing**.
2. Click **"Create load balancer"** > Choose **HTTP(S)** load balancer > **Start configuration**
3. Name: `web-url-map`
4. **Backend configuration**:
   - Click **"Create backend service"**
   - Name: `web-backend`
   - Protocol: **HTTP**
   - Instance group: `web-mig` (select region)
   - Port: **80**
   - Health check: `lb-health-check`
   - Click **"Create"**

![backend](/Screenshots/backend.jpg)

---

## 🌐 Step 7: Configure the Frontend

1. Under **Frontend configuration**, click **"Create frontend"**
2. Name: **web-frontend**
3. Protocol: **HTTP**
4. IP version: IPv4
5. Select: **Ephemeral IP**
6. Port: **80**
7. Click **"Done"**

![frontend](/Screenshots/frontend.jpg)

---

## ✅ Step 8: Review & Create Load Balancer

1. Review all settings.
2. Click **"Create"**
3. Wait ~3 minutes for propagation.
4. Copy the **external IP address** of the load balancer.

![load-balancer1](/Screenshots/load-balancer1.jpg)
![load-balancer2](/Screenshots/load-balancer2.jpg)

---

## 🌐 Step 9: Verify Web Output

Open the external IP address in your browser.

✅ You should see:

![brazil1](/Screenshots/brazil1.jpg)
![brazil2](/Screenshots/brazil2.jpg)
![brazil3](/Screenshots/brazil3.jpg)

---

## 🧹 Cleanup

To avoid incurring charges:

- Delete the Load Balancer
- Delete the Managed Instance Group
- Delete the Instance Template
- Delete the VPC and Firewall Rules

---

## 🙌 Acknowledgments

- Built for the **GCP Regional Load Balancer**
- Created by **T.I.Q.S.**
- Special thanks to **Sensei Theo** and **Lord Beron**

---

© 2025 TIQS | Regional Deployment: São Paulo 🇧🇷
