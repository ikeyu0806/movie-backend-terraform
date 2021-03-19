resource "aws_nat_gateway" "movie-backend-nat-1a" {
  subnet_id     = aws_subnet.movie-backend-public-1a.id
  allocation_id = aws_eip.movie-backend-nat-1a.id

  tags = {
    Name = "movie-backend-1a"
  }
}

resource "aws_nat_gateway" "movie-backend-nat-1c" {
  subnet_id     = aws_subnet.movie-backend-public-1c.id
  allocation_id = aws_eip.movie-backend-nat-1c.id

  tags = {
    Name = "movie-backend-1c"
  }
}

resource "aws_nat_gateway" "movie-backend-nat-1d" {
  subnet_id     = aws_subnet.movie-backend-public-1d.id
  allocation_id = aws_eip.movie-backend-nat-1d.id

  tags = {
    Name = "movie-backend-1d"
  }
}
