resource "aws_ecs_cluster" "movie-backend" {
  name = "movie_backend"
}

resource "aws_ecs_service" "movie-backend" {
  name = "movie-backend"

  depends_on = [aws_lb_listener_rule.movie-backend, aws_lb_listener_rule.movie-backend-api]

  cluster = aws_ecs_cluster.movie-backend.name

  launch_type = "FARGATE"

  desired_count = "1"

  task_definition = aws_ecs_task_definition.movie-backend.arn

  network_configuration {
    subnets         = [aws_subnet.movie-backend-private-1a.id, aws_subnet.movie-backend-private-1c.id, aws_subnet.movie-backend-private-1d.id]
    security_groups = [aws_security_group.movie-backend-ecs.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.movie-backend.arn
    container_name   = "movie_backend"
    container_port   = "8080"
  }
}

resource "aws_ecs_task_definition" "movie-backend" {
  family = "movie_backend"

  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  network_mode = "awsvpc"

  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOL
[
  {
    "name": "movie_backend",
    "image": "public.ecr.aws/e9z3g6v3/movie-test:latest",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ],
    "environment": [
      {
        "valueFrom": "${aws_db_instance.movie-backend.endpoint}",
        "name": "DB_HOST"
      },
      {
        "valueFrom": "${var.db_user}",
        "name": "DB_USER"
      },
      {
        "valueFrom": "${var.db_pass}",
        "name": "DB_PASSWORD"
      },
      {
        "valueFrom": "${aws_db_instance.movie-backend.name}",
        "name": "DB_NAME"
      }
    ]
  }
]
EOL
}
