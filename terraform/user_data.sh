#!/bin/bash
set -ex

# Update system
yum update -y

# Install Docker
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Install SSM Agent (pre-installed on Amazon Linux 2023, but ensure it's running)
yum install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

echo "Bootstrap complete! Instance ready for deployments."
EOF