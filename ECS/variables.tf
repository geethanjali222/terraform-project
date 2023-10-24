variable "region" {
  description = "The AWS region where i want to deploy resources."
  default     = "us-east-1"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  default     = "my-cluster"
}

variable "ecs_execution_role_name" {
  description = "The name of the IAM role for ECS task execution."
  default     = "ecs_execution_role"
}

variable "load_balancer_name" {
  description = "The name of the Application Load Balancer."
  default     = "my-app-lb"
}

variable "load_balancer_subnets" {
  description = "A list of subnet IDs for the Application Load Balancer."
  type        = list(string)
  default     = ["subnet-06b27039b18569e06", "subnet-0a5b11c7b884e3597"]
}

variable "load_balancer_vpc_id" {
  description = "The ID of the VPC for the Load Balancer."
  default     = "vpc-0b3c3333643d21043"
}

variable "target_group_name" {
  description = "The name of the target group for the ECS service."
  default     = "my-target-group"
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  default     = "my-app-service"
}

variable "ecs_service_subnets" {
  description = "A list of subnet IDs for the ECS service."
  type        = list(string)
  default     = ["subnet-06b27039b18569e06", "subnet-0a5b11c7b884e3597"]
}

variable "ecs_service_security_groups" {
  description = "A list of security group IDs for the ECS service."
  type        = list(string)
  default     = ["sg-0a77ec80ab4ff9107"]
}

variable "container_name" {
  description = "The name of the container for the ECS service."
  default     = "my-app-container"
}

variable "container_port" {
  description = "The port on which the container listens."
  default     = 80
}
