variable "aws_profile" {
  type    = string
  default = "default"
}

variable "environment" {
  type        = string
  description = "name of the environment/stack"
  default     = "dev"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "team" {
  type        = string
  description = "team name"
  default     = "platform"
}

// ECS Service variables
variable "application_name" {
  type        = string
  description = "name of the application"
  default     = "batch-app-demo"
}

variable "cluster_name" {
  type        = string
  description = "value of the cluster name"
  default     = "ecs-scheduled-task"
}
