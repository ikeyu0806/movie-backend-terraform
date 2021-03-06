resource "aws_ecs_cluster" "movie-backend" {
  name = "movie_backend"
}

resource "aws_ecs_service" "movie-backend" {
  name = "movie-backend"

  depends_on = [aws_lb.movie-backend-alb,
    aws_lb_listener.movie-backend,
  aws_lb_listener_rule.movie-backend]

  cluster = aws_ecs_cluster.movie-backend.name

  launch_type = "FARGATE"

  desired_count = "1"

  # enable_execute_command = true

  task_definition = aws_ecs_task_definition.movie-backend.arn

  network_configuration {
    subnets         = [aws_subnet.movie-backend-private-1a.id, aws_subnet.movie-backend-private-1c.id]
    security_groups = [aws_security_group.movie-backend-ecs.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "movie_backend"
    container_port   = "8080"
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}

resource "aws_ecs_task_definition" "movie-backend" {
  family = "movie_backend"

  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  network_mode = "awsvpc"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOL
[
  {
    "name": "movie_backend",
    "image": "public.ecr.aws/e9z3g6v3/movie-info-backend:latest",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ],
    "environment": [
      {
        "name": "DB_HOST",
        "value": "${aws_db_instance.movie-backend.endpoint}"
      },
      {
        "name": "DB_USER",
        "value": "${var.db_user}"
      },
      {
        "name": "DB_PASSWORD",
        "value": "${var.db_pass}"
      },
      {
        "name": "DB_NAME",
        "value": "${aws_db_instance.movie-backend.name}"
      },
      {
        "name": "DATA_SOURCE",
        "value": "${var.db_user}:${var.db_pass}@tcp(${aws_db_instance.movie-backend.endpoint})/${aws_db_instance.movie-backend.name}?charset=utf8&parseTime=True&loc=Local"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "movie-backend",
        "awslogs-group": "/ecs/movie-backend"
      }
    }
  }
]
EOL
}

resource "aws_ecs_task_definition" "movie-db-migration" {
  family = "movie_db_migration"

  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  network_mode = "awsvpc"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOL
[
  {
    "name": "movie_db_migrate",
    "image": "public.ecr.aws/e9z3g6v3/movie-info-backend:latest",
    "command": ["sql-migrate", "up"],
    "environment": [
      {
        "name": "DATA_SOURCE",
        "value": "${var.db_user}:${var.db_pass}@tcp(${aws_db_instance.movie-backend.endpoint})/${aws_db_instance.movie-backend.name}?charset=utf8&parseTime=True&loc=Local"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "movie-db-migration",
        "awslogs-group": "/ecs/movie-db-migration"
      }
    }
  }
]
EOL
}
