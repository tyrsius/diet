#Lambda function
resource "aws_lambda_function" "api" {
  filename         = local.api_lambda_file
  function_name    = local.api_lamba_name
  handler          = "api.handler"
  timeout          = 30
  memory_size      = 512
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs10.x"
  source_code_hash = filebase64sha256(local.api_lambda_file)
  tags             = local.default_tags

  environment {
    variables = {
      AIRTABLE_KEY          = var.AIRTABLE_KEY
      AIRTABLE_DIET_BASE_ID = var.AIRTABLE_DIET_BASE_ID
    }
  }
}

#Role the lambda will be executed with
resource "aws_iam_role" "lambda_execution_role" {
  name = "${local.app_namespace}_LambdaRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

#Allow lambda to create cloudwatch log events, equvilant to AWSLambdaBasicExecutionRole
resource "aws_iam_role_policy" "lambda_basic_execution" {
  name = "lambda_basic_execution"
  role = aws_iam_role.lambda_execution_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:GetFunctionConfiguration",
        "lambda:InvokeAsync",
        "lambda:InvokeFunction",
        "lambda:Invoke"
      ],
      "Resource": "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${local.app_namespace}*"
    },
    {
        "Sid": "AllowAccessToOwnTables",
        "Effect": "Allow",
        "Resource": [
            "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${local.app_namespace}*"
        ],
        "Action": [
            "dynamodb:GetItem",
            "dynamodb:BatchGetItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:BatchWriteItem"
        ]
    }
  ]
}
EOF

}

