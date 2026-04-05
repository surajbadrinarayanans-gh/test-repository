# ─────────────────────────────────────────────
# terraform.tfvars — Fill in your values
# ─────────────────────────────────────────────

aws_region     = "ap-south-1"
project_name   = "rizzfitt"
environment    = "prod"

# VPC
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["ap-south-1a", "ap-south-1b"]

# EC2
instance_ami  = "ami-045443a70fafb8bbc"   # Update if needed
instance_type = "t3.micro"
key_name      = "rizzfitt-key"

# ECR
ecr_repo_name = "rizzfitt-application"

# ALB
health_check_path = "/"
app_port_blue     = 8081
app_port_green    = 8082

# GitHub OIDC
github_repo    = "surajbadrinarayanans-gh/test-repository"
aws_account_id = "389517403286"   # Your AWS account ID
