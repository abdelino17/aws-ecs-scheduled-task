data "aws_region" "current" {}

resource "aws_cloudwatch_log_group" "main" {
  name              = var.application_name
  retention_in_days = 1
}

######### ECS Tasks ###########
resource "aws_ecs_task_definition" "main" {
  family                   = var.application_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu_limit
  memory                   = var.mem_limit
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.execution_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.architecture
  }

  container_definitions = jsonencode(
    [
      {
        name      = var.application_name
        image     = "${aws_ecr_repository.this.repository_url}:${var.image_tag}"
        essential = true

        environment = var.app_environment

        healthCheck = {
          Command = [
            "CMD-SHELL",
            "echo hello"
          ]

          Interval = 5
          Timeout  = 2
          Retries  = 3
        }

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.main.name
            awslogs-region        = data.aws_region.current.name
            awslogs-stream-prefix = "batch"
          }
        }
      }
    ]
  )
}
