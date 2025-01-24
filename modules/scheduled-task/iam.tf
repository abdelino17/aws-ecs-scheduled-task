data "aws_iam_policy_document" "assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

### Execution Role
resource "aws_iam_role" "execution_role" {
  name               = "${var.application_name}-exec-role"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

resource "aws_iam_role_policy_attachment" "execution_role" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

### Task Role
resource "aws_iam_role" "task_role" {
  name               = "${var.application_name}-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

