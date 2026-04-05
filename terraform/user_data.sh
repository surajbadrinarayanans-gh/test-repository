#!/bin/bash
set -ex

# Update system
yum update -y

# Install Docker
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Install Nginx (for blue-green switching)
amazon-linux-extras install nginx1 -y 2>/dev/null || yum install -y nginx

# Configure Nginx to proxy to the blue port by default
cat > /etc/nginx/nginx.conf << 'NGINX_CONF'
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent"';

    access_log /var/log/nginx/access.log main;

    server {
        listen ${app_port_blue};
        listen ${app_port_green};

        location / {
            proxy_pass http://127.0.0.1:${app_port_blue};
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        location /health {
            return 200 'OK';
            add_header Content-Type text/plain;
        }
    }
}
NGINX_CONF

systemctl enable nginx
systemctl start nginx

# Install SSM Agent (should be pre-installed on Amazon Linux 2023)
yum install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

echo "Bootstrap complete!"
