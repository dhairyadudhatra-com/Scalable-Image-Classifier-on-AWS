resource "aws_iam_instance_profile" "webtier_iam_profile"{
  name = "webtier-iam-profile"
  role = aws_iam_role.webtier_role.name
}

resource "aws_iam_instance_profile" "apptier_iam_profile"{
  name = "apptier-iam-profile"
  role = aws_iam_role.apptier_role.name
}

resource "aws_iam_role" "webtier_role" {
  name               = "web-tier-sqs-access-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM Role for Apptier
resource "aws_iam_role" "apptier_role" {
  name               = "app-tier-sqs-s3-access-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM Policy for Webtier
resource "aws_iam_policy" "webtier_policy" {
  name        = "webtier-sqs-access-policy"
  description = "Policy for SQS access by Webtier"

  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": var.request_queue_arn
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": var.response_queue_arn
    }
  ]
})

}

# IAM Policy for Apptier
resource "aws_iam_policy" "apptier_policy" {
  name        = "apptier-sqs-s3-access-policy"
  description = "Policy for SQS and S3 access by Apptier"

  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": var.request_queue_arn
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": var.response_queue_arn
    },
    {
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": [var.input_bucket_arn, var.output_bucket_arn]
    }
  ]
})
}

# Attach policies to roles
resource "aws_iam_role_policy_attachment" "webtier_attachment" {
  role       = aws_iam_role.webtier_role.name
  policy_arn = aws_iam_policy.webtier_policy.arn
}

resource "aws_iam_role_policy_attachment" "apptier_attachment" {
  role       = aws_iam_role.apptier_role.name
  policy_arn = aws_iam_policy.apptier_policy.arn
}
