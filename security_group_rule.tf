resource "aws_security_group_rule" "movie-backend-alb-http" {
  security_group_id = aws_security_group.movie-backend-alb.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "movie_backend-api-alb-http" {
  security_group_id = aws_security_group.movie-backend-alb.id

  type = "ingress"

  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "movie-backend-ecs" {
  security_group_id = aws_security_group.movie-backend-ecs.id

  type = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "movie_backend-api-ecs" {
  security_group_id = aws_security_group.movie-backend-ecs.id

  type = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["10.0.0.0/16"]
}
