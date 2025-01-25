provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Step 1: Create the IAM Policy for Read-Only Access
resource "aws_iam_policy" "admin_read_only" {
  name        = var.policyname
  description = "IAM policy for administrative read-only access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "rds:Describe*",
          "iam:List*",
          "iam:Get*",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "lambda:ListFunctions",
          "lambda:GetFunction",
          "elasticloadbalancing:Describe*",
          "autoscaling:Describe*",
          "cloudformation:Describe*",
          "cloudtrail:LookupEvents",
          "sns:ListSubscriptions",
          "sns:ListSubscriptionsByTopic",
          "sns:ListTopics",
          "sns:GetTopicAttributes",
          "sqs:ListQueues",
          "sqs:GetQueueAttributes",
          "tag:GetResources"
        ]
        Resource = "*"
      }
    ]
  })

}

# Step 2: Create the IAM Role
resource "aws_iam_role" "admin_read_only_role" {
  name = var.rolename
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Change this if you want to allow other services or users
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name   = "${var.env}_admin_read-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = var.env
  }
}

# Step 3: Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "attach_admin_read_only" {
  policy_arn = aws_iam_policy.admin_read_only.arn
  role       = aws_iam_role.admin_read_only_role.name
}