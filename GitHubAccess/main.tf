resource "aws_iam_role" "github_access_role" {
  name = "GitHubAccessRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:Requester": "github.com"
        }
      }
    }
  ]
}
EOF
}
