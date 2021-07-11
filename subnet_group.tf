resource "aws_db_subnet_group" "movie-backend-db-subnet" {
  name        = "movie-rds-subnet-group"
  subnet_ids  = [aws_subnet.movie-backend-public-1a.id, aws_subnet.movie-backend-public-1c.id]
}
