# ─────────────────────────────────────────────
# Outputs
# ─────────────────────────────────────────────

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID (use this in GitHub Secrets)"
  value       = aws_instance.app_server.id
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.app_server.private_ip
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app_repo.repository_url
}

output "alb_dns_name" {
  description = "ALB DNS name (use this to access your app)"
  value       = aws_lb.app.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.app.arn
}

output "github_actions_role_arn" {
  description = "GitHub Actions OIDC role ARN (use this in GitHub Secrets)"
  value       = aws_iam_role.github_actions_role.arn
}

output "blue_target_group_arn" {
  description = "Blue target group ARN"
  value       = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  description = "Green target group ARN"
  value       = aws_lb_target_group.green.arn
}
