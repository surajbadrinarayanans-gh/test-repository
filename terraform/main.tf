# ─────────────────────────────────────────────
# EC2 Instance — Private Subnet (NO public IP)
# ─────────────────────────────────────────────
resource "aws_instance" "app_server" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  # No public IP — instance is only reachable via ALB
  associate_public_ip_address = false

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    app_port_blue  = var.app_port_blue
    app_port_green = var.app_port_green
  }))

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "${var.project_name}-app-server"
  }

  # Wait for VPC endpoints to be available before launching
  depends_on = [
    aws_vpc_endpoint.ssm,
    aws_vpc_endpoint.ssm_messages,
    aws_vpc_endpoint.ec2_messages,
    aws_vpc_endpoint.ecr_api,
    aws_vpc_endpoint.ecr_dkr,
    aws_vpc_endpoint.s3
  ]
}
