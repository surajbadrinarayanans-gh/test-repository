# ─────────────────────────────────────────────
# General
# ─────────────────────────────────────────────
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for tagging and naming"
  type        = string
  default     = "rizzfitt"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

# ─────────────────────────────────────────────
# VPC & Networking
# ─────────────────────────────────────────────
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (ALB needs at least 2 AZs)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (EC2 instances)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "AZs to deploy subnets into"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

# ─────────────────────────────────────────────
# EC2
# ─────────────────────────────────────────────
variable "instance_ami" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 in ap-south-1)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "rizzfitt-key"
}

# ─────────────────────────────────────────────
# ECR
# ─────────────────────────────────────────────
variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "rizzfitt-application"
}

# ─────────────────────────────────────────────
# ALB
# ─────────────────────────────────────────────
variable "health_check_path" {
  description = "Health check path for ALB target group"
  type        = string
  default     = "/"
}

variable "app_port_blue" {
  description = "Port for the blue deployment"
  type        = number
  default     = 8081
}

variable "app_port_green" {
  description = "Port for the green deployment"
  type        = number
  default     = 8082
}

# ─────────────────────────────────────────────
# GitHub Actions OIDC
# ─────────────────────────────────────────────
variable "github_repo" {
  description = "GitHub repo in format org/repo"
  type        = string
  default     = "surajbadrinarayanans-gh/test-repo"
}

variable "aws_account_id" {
  description = "Your AWS Account ID"
  type        = string
}
