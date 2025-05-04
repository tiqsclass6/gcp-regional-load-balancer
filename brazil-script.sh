#!/bin/bash
apt update
apt install -y apache2

systemctl enable apache2
systemctl start apache2

# GCP Metadata
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
HDR="Metadata-Flavor: Google"

local_ipv4=$(curl -H "$HDR" -s "$METADATA_URL/instance/network-interfaces/0/ip")
zone=$(curl -H "$HDR" -s "$METADATA_URL/instance/zone")
project_id=$(curl -H "$HDR" -s "$METADATA_URL/project/project-id")
network_tags=$(curl -H "$HDR" -s "$METADATA_URL/instance/tags")

# Write custom HTML
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>GCP Regional Load Balancer</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>
    body, html { height: 100%; margin: 0; font-family: Arial, sans-serif; }
    .bgimg {
      background-image: url('https://brazil-2025.s3.us-east-1.amazonaws.com/brazil-bg.jpg');
      height: 100%;
      background-position: center;
      background-size: cover;
    }
    .content {
      background-color: rgba(0, 0, 0, 0.6);
      color: white;
      padding: 20px;
      border-radius: 10px;
      position: absolute;
      bottom: 30px;
      left: 30px;
    }
  </style>
</head>
<body>
  <div class="bgimg">
    <div class="content">
      <h1>I, TIQS, thank you, Sensei Theo and Lord Beron!</h1>
      <p><b>Instance Name:</b> $(hostname -f)</p>
      <p><b>Internal IP:</b> $local_ipv4</p>
      <p><b>Zone:</b> $zone</p>
      <p><b>Project ID:</b> $project_id</p>
      <p><b>Tags:</b> $network_tags</p>
      <img src="https://brazil-2025.s3.us-east-1.amazonaws.com/brazil5.gif" width="220" height="398">
    </div>
  </div>
</body>
</html>
EOF