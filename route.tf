resource "aws_route_table" "movie-backend-public" {
  vpc_id = aws_vpc.movie-backend.id

  tags = {
    Name = "movie-backend-public"
  }
}

resource "aws_route" "movie-backend-public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.movie-backend-public.id
  gateway_id             = aws_internet_gateway.movie-backend.id
}

resource "aws_route_table_association" "movie-backend-public-1a" {
  subnet_id      = aws_subnet.movie-backend-public-1a.id
  route_table_id = aws_route_table.movie-backend-public.id
}

resource "aws_route_table_association" "movie-backend-public-1c" {
  subnet_id      = aws_subnet.movie-backend-public-1c.id
  route_table_id = aws_route_table.movie-backend-public.id
}

resource "aws_route_table" "movie-backend-private-1a" {
  vpc_id = aws_vpc.movie-backend.id

  tags = {
    Name = "movie-backend-private-1a"
  }
}

resource "aws_route_table" "movie-backend-private-1c" {
  vpc_id = aws_vpc.movie-backend.id

  tags = {
    Name = "movie-backend-private-1c"
  }
}

resource "aws_route" "movie-backend-private-1a" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.movie-backend-private-1a.id
  nat_gateway_id         = aws_nat_gateway.movie-backend-nat-1a.id
}

resource "aws_route" "movie-backend-private-1c" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.movie-backend-private-1c.id
  nat_gateway_id         = aws_nat_gateway.movie-backend-nat-1c.id
}

resource "aws_route_table_association" "movie-backend-private-1a" {
  subnet_id      = aws_subnet.movie-backend-private-1a.id
  route_table_id = aws_route_table.movie-backend-private-1a.id
}

resource "aws_route_table_association" "movie-backend-private-1c" {
  subnet_id      = aws_subnet.movie-backend-private-1c.id
  route_table_id = aws_route_table.movie-backend-private-1c.id
}

