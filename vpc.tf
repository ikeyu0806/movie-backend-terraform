resource "aws_vpc" "movie-backend" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "movie-backend"
  }
}
