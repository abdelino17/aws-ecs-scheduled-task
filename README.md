# AWS ECS SCheduled Task

![terraform](https://img.shields.io/badge/terraform-1.10.4-informational)
![Twitter Follow](https://img.shields.io/twitter/follow/abdelFare?logoColor=lime&style=social)

This repository contains the terraform code to deploy an [ECS Scheduled Task](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/scheduling_tasks.html).

## Usage

1. Download [terraform cli](https://www.terraform.io/)
2. Clone this Repo `git clone https://github.com/abdelino17/aws-ecs-scheduled-task`
3. Navigate to the new folder `aws-ecs-scheduled-task`
4. Set the `AWS_PROFILE` and `TF_VAR_aws_profile` environment variables
5. Init the infrastructure: `terraform init`
6. Deploy your infrastructure: `terraform apply`
7. Push the Docker Image of your application into ECR. The `golang-worker` used in the infrastructure is available [here](https://github.com/abdelino17/golang-worker).
