data "aws_iam_policy_document" "event_access_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "events.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "event_role" {
  name               = "${var.application_name}-event-role"
  assume_role_policy = data.aws_iam_policy_document.event_access_policy_document.json
}

/*
If your scheduled tasks require the use of the task execution role, a task role, or a task role override,
then you must add iam:PassRole permissions for each task execution role, task role, or task role override
to the CloudWatch Events IAM role.
*/
data "aws_iam_policy_document" "event_pass_role" {
  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }

    resources = [
      # should be the arn of the task/execution role
      aws_iam_role.execution_role.arn,
      aws_iam_role.task_role.arn
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["ecs:RunTask"]

    resources = [
      replace(aws_ecs_task_definition.main.arn, "/:\\d+$/", ":*")
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["ecs:TagResource"]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "ecs:CreateAction"

      values = ["RunTask"]
    }
  }
}

resource "aws_iam_policy" "event_pass_role" {
  name   = "${var.application_name}-event-role"
  policy = data.aws_iam_policy_document.event_pass_role.json
}

resource "aws_iam_role_policy_attachment" "event_pass_role" {
  role       = aws_iam_role.event_role.name
  policy_arn = aws_iam_policy.event_pass_role.arn
}

###################################################
# CLOUDWATCH EVENT RULE
###################################################

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "${var.application_name}-event-rule"
  description         = var.rule_description
  schedule_expression = var.schedule_expression
  role_arn            = aws_iam_role.event_role.arn
}

###################################################
# CLOUDWATCH EVENT TARGET
###################################################
resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = var.application_name
  arn       = var.ecs_cluster_arn
  role_arn  = aws_iam_role.event_role.arn

  ecs_target {
    task_definition_arn = aws_ecs_task_definition.main.arn
    task_count          = var.desired_count
    launch_type         = "FARGATE"

    network_configuration {
      subnets         = var.subnets_id
      security_groups = [aws_security_group.service.id]
    }
  }
}
