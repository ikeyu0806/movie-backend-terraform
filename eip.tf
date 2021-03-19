resource "aws_eip" "movie-backend-nat-1a" {
  vpc = true

  tags = {
    Name = "movie-backend-natgw-1a"
  }
}

resource "aws_eip" "movie-backend-nat-1b" {
  vpc = true

  tags = {
    Name = "movie-backend-natgw-1b"
  }
}

resource "aws_eip" "movie-backend-nat-1c" {
  vpc = true

  tags = {
    Name = "movie-backend-natgw-1c"
  }
}

resource "aws_eip" "movie-backend-nat-1d" {
  vpc = true

  tags = {
    Name = "movie-backend-natgw-1d"
  }
}
