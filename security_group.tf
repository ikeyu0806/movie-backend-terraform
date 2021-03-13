resource "aws_security_group" "ecs" {
  name        = "movie-backend-ecs"
  description = "movie-backend ecs"

  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "movie-backend-ecs"
  }
}

resource "aws_security_group" "alb" {
  name        = "movie-backend-alb"
  description = "movie-backend alb"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "movie-backend-alb"
  }
}
