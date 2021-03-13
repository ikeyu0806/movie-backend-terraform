resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "movie-backend"

  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_1a.id, aws_subnet.public_1c.id, aws_subnet.public_1d.id]
}

resource "aws_lb_target_group" "main" {
  name = "main"

  vpc_id = aws_vpc.main.id

  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 80
    path = "/"
  }
}

resource "aws_lb_target_group" "movie-backend" {
  name = "movie-backend"

  vpc_id = aws_vpc.main.id

  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 8080
    path = "/"
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_listener_rule" "movie-backend" {
  listener_arn = aws_lb_listener.movie-backend.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.movie-backend.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_listener" "main" {
  port              = "80"
  protocol          = "HTTP"

  load_balancer_arn = aws_lb.main.arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

resource "aws_lb_listener" "movie-backend" {
  port              = "8080"
  protocol          = "HTTP"

  load_balancer_arn = aws_lb.main.arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

