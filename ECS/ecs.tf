module "ecs" {
  source                      = "../../module/ECS" 
  region                      = var.region
  ecs_cluster_name            = var.ecs_cluster_name
  ecs_execution_role_name     = var.ecs_execution_role_name
  load_balancer_name          = var.load_balancer_name
  load_balancer_subnets       = var.load_balancer_subnets
  load_balancer_vpc_id        = var.load_balancer_vpc_id
  target_group_name           = var.target_group_name
  ecs_service_name            = var.ecs_service_name
  ecs_service_subnets         = var.ecs_service_subnets
  ecs_service_security_groups = var.ecs_service_security_groups
  container_name              = var.container_name
  container_port              = var.container_port

}
