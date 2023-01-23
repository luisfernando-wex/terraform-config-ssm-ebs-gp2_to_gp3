provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "example_role" {
  name = "example_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "example_policy" {
  name = "example_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:ModifyVolume",
        "ec2:DescribeVolumes"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_attach" {
  role = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.example_policy.arn
}

resource "aws_lambda_function" "example_function" {
  function_name = "example_function"
  role = aws_iam_role.example_role.arn
  handler = "index.handler"
  runtime = "python3.8"
  source_code

  ############ Adjust the source code above
  
  resource "aws_lambda_function" "example_function" {
  function_name = "example_function"
  role = aws_iam_role.example_role.arn
  handler = "index.handler"
  runtime = "python3.8"
  source_code_zip = "${file("lambda_function.zip")}"
  environment {
    variables = {
      "source_account_id" = "123456789012"
    }
  }
}

resource "aws_config_rule" "example_rule" {
  name = "example_rule"
  description = "Check for GP2 EBS volumes"
  source {
    owner = "AWS"
    source_identifier = "EC2_EBS_VOLUME_TYPE_CHECK"
  }
  scope {
    compliance_resource_id = "*"
    compliance_resource_types = ["AWS::EC2::Volume"]
  }
}

resource "aws_config_config_rule" "example_config_rule" {
  config_rule_name = aws_config_rule.example_rule.name
  depends_on = [aws_lambda_function.example_function]
  remediation_config {
    automatic = true
    lambda_function_association {
      lambda_function_arn = aws_lambda_function.example_function.arn
      event_source = "aws.config"
    }
  }
}

resource "aws_ssm_compliance_item" "example_compliance_item" {
  name = "example_compliance_item"
  compliance_type = "Custom"
  resource_type = "AWS::EC2::Volume"
  rule_parameters = <<EOF
{
  "volumeType": "gp2"
}
EOF
}

  
  
