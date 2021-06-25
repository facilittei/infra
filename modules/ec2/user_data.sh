#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
EC2ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "<center><h1>EC2 Instance ID: $EC2ID</h1></center>" > /var/www/html/index.html