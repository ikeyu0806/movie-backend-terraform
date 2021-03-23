resource "aws_ssm_parameter" "movie-backend-db-password" {
  name = "db-password"
  value = var.db_pass
  type = "SecureString"
  description = "db_pass"
}
