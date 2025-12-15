resource "aws_lb" "application_load_balancer" {
  name               = "quiz-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in var.vpc.public_subnets : subnet.id]
  security_groups    = [var.sg.lb]

  tags = {
    Name = "quiz-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "quiz-tg"
  port        = var.container_nginx_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc.vpc_id

  health_check {
    path                = "/healthcheck"
    protocol            = "HTTP"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }

  tags = {
    Name = "quiz-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}