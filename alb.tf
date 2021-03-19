resource "aws_lb" "movie-backend-alb" {
  load_balancer_type = "application"
  name               = "movie-backend"

  security_groups = [aws_security_group.movie-backend-alb.id]
  subnets         = [aws_subnet.movie-backend-public-1a.id, aws_subnet.movie-backend-public-1c.id, aws_subnet.movie-backend-public-1d.id]
}

resource "aws_lb_target_group" "movie-backend" {
  name = "movie-backend-alb"

  vpc_id = aws_vpc.movie-backend.id

  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 80
    path = "/"
  }
}

resource "aws_lb_target_group" "movie-backend-api" {
  name = "movie-backend"

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
    target_group_arn = aws_lb_target_group.movie-backend.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_listener_rule" "movie-backend-api" {
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

resource "aws_lb_listener" "movie-backend" {
  port              = "80"
  protocol          = "HTTP"

  load_balancer_arn = aws_lb.movie-backend-alb.arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

resource "aws_lb_listener" "movie-backend-api" {
  port              = "8080"
  protocol          = "HTTP"

  load_balancer_arn = aws_lb.movie-backend-alb.arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

