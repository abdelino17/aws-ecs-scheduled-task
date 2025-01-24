variable "application_name" {
  description = "name for the application"
  type        = string
}

variable "architecture" {
  type        = string
  description = "architecture of the cpu"
  default     = "ARM64"
}

variable "cpu_limit" {
  type        = number
  description = "amount of cpu"
  default     = 256
}

variable "mem_limit" {
  type        = number
  description = "amount of memory"
  default     = 512
}

variable "ecs_cluster_arn" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

#### cron variables
variable "desired_count" {
  type        = number
  description = "number of tasks"
  default     = 1
}

variable "rule_description" {
  description = "The description of the rule."
  type        = string
  default     = "This rule allow to execute a Batch"
}

variable "schedule_expression" {
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)"
  type        = string
}

##### SG variables
variable "vpc_id" {
  type = string
}

variable "environment" {
  type        = string
  description = "name of the environment/stack"
}

variable "image_tag" {
  type        = string
  description = "tag for the image"
  default     = "latest"
}

variable "app_environment" {
  type        = list(map(string))
  description = "environment parameters for the application"
  default     = []
}
