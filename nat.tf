resource "aws_nat_gateway" "movie-backend-nat-1a" {
  subnet_id     = aws_subnet.movie-backend-public-1a.id
  allocation_id = aws_eip.movie-backend-nat-1a.id

  depends_on = [aws_internet_gateway.movie-backend]

  tags = {
    Name = "movie-backend-1a"
  }
}

resource "aws_nat_gateway" "movie-backend-nat-1c" {
  subnet_id     = aws_subnet.movie-backend-public-1c.id
  allocation_id = aws_eip.movie-backend-nat-1c.id

  depends_on = [aws_internet_gateway.movie-backend]

  tags = {
    Name = "movie-backend-1c"
  }
}
