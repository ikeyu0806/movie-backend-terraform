resource "aws_cloudwatch_log_group" "movie-backend" {
  name              = "/ecs/movie-backend"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "movie-db-migration" {
  name              = "/ecs/movie-db-migration"
  retention_in_days = 180
}
