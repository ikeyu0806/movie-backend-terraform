resource "aws_codedeploy_app" "movie-backend" {
  compute_platform = "ECS"
  name             = "movie-backend"
}

resource "aws_codedeploy_deployment_group" "movie-backend" {
  deployment_group_name = "movie-backend"

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  app_name               = aws_codedeploy_app.movie-backend.name
  service_role_arn       = aws_iam_role.codedeploy.arn

  depends_on = [aws_ecs_service.movie-backend]

  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE"
    ]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.movie-backend.name
    service_name = "movie-backend"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [
          aws_lb_listener.movie-backend.arn
        ]
      }
      target_group {
        name = aws_lb_target_group.blue.name
      }
      target_group {
        name = aws_lb_target_group.green.name
      }
    }
  }
}
