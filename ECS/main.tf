provider "aws" {
  region = "us-east-1"  
}

# Create an ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

# Create an IAM role for ECS task execution
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the IAM policy to the ECS execution role
resource "aws_iam_policy_attachment" "ecs_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  roles      = [aws_iam_role.ecs_execution_role.name]
}

# Create an Application Load Balancer
resource "aws_lb" "my_app_lb" {
  name               = "my-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-06b27039b18569e06", "subnet-0a5b11c7b884e3597"]  
  enable_deletion_protection = false
}

# Create a target group for the ECS service
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0b3c3333643d21043"  
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Create an HTTP listener for the Load Balancer
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "OK"
    }
  }
}

# Create an ECS service with Auto Scaling
resource "aws_appautoscaling_target" "my_scaling_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/my-cluster/my-app-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "my_scaling_policy" {
  name               = "my-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.my_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.my_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.my_scaling_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
    target_value        = 50
  }
}

# Create an ECS service
resource "aws_ecs_service" "my_app_service" {
  name            = "my-app-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "EC2"
  network_configuration {
    subnets = ["subnet-06b27039b18569e06", "subnet-0a5b11c7b884e3597"]  
    security_groups = ["sg-0a77ec80ab4ff9107"]  
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "my-app-container"
    container_port   = 80
  }
}
