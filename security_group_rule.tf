resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_http_movie_backend" {
  security_group_id = aws_security_group.alb.id

  type = "ingress"

  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "ecs_movie_backend" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["10.0.0.0/16"]
}
