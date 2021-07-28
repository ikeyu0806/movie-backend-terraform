resource "aws_subnet" "movie-backend-public-1a" {
  vpc_id = aws_vpc.movie-backend.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "movie-backend-public-1a"
  }
}

resource "aws_subnet" "movie-backend-public-1c" {
  vpc_id = aws_vpc.movie-backend.id

  availability_zone = "ap-northeast-1c"

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "movie-backend-public-1c"
  }
}

resource "aws_subnet" "movie-backend-private-1a" {
  vpc_id = aws_vpc.movie-backend.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.10.0/24"

  tags = {
    Name = "movie-backend-private-1a"
  }
}

resource "aws_subnet" "movie-backend-private-1c" {
  vpc_id = aws_vpc.movie-backend.id

  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.20.0/24"

  tags = {
    Name = "movie-backend-private-1c"
  }
}
