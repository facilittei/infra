resource "aws_lb" "main" {
  name               = "${var.product}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = data.aws_subnet_ids.public.ids

  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "http" {
  name        = "http-${var.product}-${var.environment}"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }

  tags = {
    Name        = "http-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }

  tags = {
    Name        = "http-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_alb_target_group_attachment" "http" {
  count            = length(aws_instance.api)
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = element(aws_instance.api.*.id, count.index)
  port             = 80

  depends_on = [
    aws_instance.api
  ]
}
