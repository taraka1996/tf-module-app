resource "aws_iam_policy" "main" {
  name        = "${var.component}-${var.env}"
  path        = "/"
  description = "${var.component}-${var.env}"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        //        "Resource" : [
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.${var.component}.*",
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.docdb.*",
        //          "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.elasticache.*"
        //          /// How to limit this permissions, which are unwanted for all components
        //        ]
        Resource : [for k in local.parameters : "arn:aws:ssm:us-east-1:${data.aws_caller_identity.account.account_id}:parameter/${var.env}.${k}.*"]
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : "ssm:DescribeParameters",
        "Resource" : "*"
      }
    ]
  })
}