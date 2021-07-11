resource "aws_eip" "movie-backend-nat-1a" {
  vpc = true

  depends_on = [aws_internet_gateway.movie-backend]

  tags = {
    Name = "movie-backend-natgw-1a"
  }
}

resource "aws_eip" "movie-backend-nat-1b" {
  vpc = true

  depends_on = [aws_internet_gateway.movie-backend]

  tags = {
    Name = "movie-backend-natgw-1b"
  }
}

resource "aws_eip" "movie-backend-nat-1c" {
  vpc = true

  depends_on = [aws_internet_gateway.movie-backend]

  tags = {
    Name = "movie-backend-natgw-1c"
  }
}
