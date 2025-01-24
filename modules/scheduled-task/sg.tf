######### Security group ###########

resource "aws_security_group" "service" {
  name        = "${var.application_name}-sg"
  vpc_id      = var.vpc_id
  description = "ECS task security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
