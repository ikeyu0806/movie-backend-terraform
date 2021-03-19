resource "aws_internet_gateway" "movie-backend" {
  vpc_id = aws_vpc.movie-backend.id

  tags = {
    Name = "movie-backend"
  }
}
