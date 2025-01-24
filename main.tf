
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "192.168.251.0/24"
}

module "golang_worker" {
  source              = "./modules/scheduled-task"
  vpc_id              = module.vpc.vpc_id
  subnets_id          = module.vpc.private_subnets
  application_name    = "golang-worker"
  ecs_cluster_arn     = aws_ecs_cluster.this.arn
  environment         = var.environment
  image_tag           = "latest"
  schedule_expression = "rate(5 minutes)"
  app_environment = [
    {
      Name  = "ENVIRONMENT"
      Value = var.environment
    },
    {
      Name  = "NUM_WORKERS"
      Value = 5
    },
    {
      Name  = "NUM_JOBS"
      Value = 5
    },
  ]
}
