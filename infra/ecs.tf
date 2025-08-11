resource "aws_ecs_cluster" "my_cluster" {
  name = var.ECS_CLUSTER_NAME
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/my-container"
  retention_in_days = 30
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = var.ECS_TASK_FAMILY
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.CONTAINER_NAME
      image     = "${aws_ecr_repository.myapp.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = var.AWS_REGION
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = var.ECS_SERVICE_NAME
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  depends_on = [ aws_alb_listener.my_listener ]

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = var.CONTAINER_NAME
    container_port   = 80
  }

  network_configuration {
    subnets          = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]  # Or use private subnet if you prefer
    security_groups  = [aws_security_group.ecs-securitygroup.id]
    assign_public_ip = true
  }
}