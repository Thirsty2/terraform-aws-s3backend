resource "aws_iam_role" "iam_role" {
  name = "tf-assume-role"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
              "AWS": "${var.assume_role_account_id}"
          },
          "Effect": "Allow"
        }
      ]
    }
  EOF

  tags = {
    ResourceGroup = var.namespace 
  }
}

data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_bucket.arn
    ]
  }

  statement {
    actions = ["s3:GetObject", "s3:PutObject"]

    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [aws_dynamodb_table.dynamodb_table.arn]
  }
}

resource "aws_iam_policy" "iam_policy" {
  name = "tf-policy"
  path = "/"
  policy = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}
