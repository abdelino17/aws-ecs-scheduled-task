terraform {
  backend "s3" {
    bucket = "abdelino17-bucket-demo"
    acl    = "bucket-owner-full-control"
    key    = "dev/aws-ecs-scheduled-task.tfstate"
    region = "us-east-1"
  }
}
