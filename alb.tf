resource "aws_lb" "movie-backend-alb" {
  load_balancer_type = "application"
  name               = "movie-backend"

  security_groups = [aws_security_group.movie-backend-alb.id]
  subnets         = [aws_subnet.movie-backend-public-1a.id, aws_subnet.movie-backend-public-1c.id]
}

resource "aws_lb_target_group" "blue" {
  name = "movie-backend-blue"

  vpc_id = aws_vpc.movie-backend.id

  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 8080
    path = "/"
  }
}

resource "aws_lb_target_group" "green" {
  name = "movie-backend-green"

  vpc_id = aws_vpc.movie-backend.id

  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 8080
    path = "/"
  }
}


resource "aws_lb_listener_rule" "movie-backend" {
  listener_arn = aws_lb_listener.movie-backend.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_listener" "movie-backend" {
  port     = "8080"
  protocol = "HTTP"

  load_balancer_arn = aws_lb.movie-backend-alb.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

# 無効化中
# resource "aws_alb_listener" "movie-backend-alb-443" {
#   load_balancer_arn = aws_lb.movie-backend-alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.movie-backend-acm.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.blue.arn
#   }
# }
