resource "aws_ecs_cluster" "main" {
  name = "movie_backend"
}

resource "aws_ecs_service" "main" {
  name = "movie-backend"

  depends_on = [aws_lb_listener_rule.main, aws_lb_listener_rule.movie-backend]

  cluster = aws_ecs_cluster.main.name

  launch_type = "FARGATE"

  desired_count = "1"

  task_definition = aws_ecs_task_definition.main.arn

  network_configuration {
    subnets         = [aws_subnet.private_1a.id, aws_subnet.private_1c.id, aws_subnet.private_1d.id]
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.movie-backend.arn
    container_name   = "movie_backend"
    container_port   = "8080"
  }
}

resource "aws_ecs_task_definition" "main" {
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
    ]
  }
]
EOL
}
