# ─────────────────────────────────────────────
# Application Load Balancer (public-facing)
# ─────────────────────────────────────────────
resource "aws_lb" "app" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# ─────────────────────────────────────────────
# Target Group — Blue (port 8081)
# ─────────────────────────────────────────────
resource "aws_lb_target_group" "blue" {
  name        = "${var.project_name}-blue-tg"
  port        = var.app_port_blue
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    port                = tostring(var.app_port_blue)
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = {
    Name = "${var.project_name}-blue-tg"
  }
}

# ─────────────────────────────────────────────
# Target Group — Green (port 8082)
# ─────────────────────────────────────────────
resource "aws_lb_target_group" "green" {
  name        = "${var.project_name}-green-tg"
  port        = var.app_port_green
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    port                = tostring(var.app_port_green)
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = {
    Name = "${var.project_name}-green-tg"
  }
}

# ─────────────────────────────────────────────
# Register EC2 in BOTH target groups
# ─────────────────────────────────────────────
resource "aws_lb_target_group_attachment" "blue" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.app_server.id
  port             = var.app_port_blue
}

resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.app_server.id
  port             = var.app_port_green
}

# ─────────────────────────────────────────────
# Listener — HTTP:80 → forwards to Blue by default
# ─────────────────────────────────────────────
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  tags = {
    Name = "${var.project_name}-http-listener"
  }
}
