variable "db_user" {}
variable "db_pass" {}

resource "aws_db_instance" "movie-backend" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  name                    = "movieInfo"
  username                = var.db_user
  password                = var.db_pass
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  port                    = 3306
  vpc_security_group_ids  = [aws_security_group.movie-backend-rds-sg.id]
  db_subnet_group_name    = aws_db_subnet_group.movie-backend-db-subnet.name
}
