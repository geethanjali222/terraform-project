resource "aws_iam_policy" "s3_access_policy" {
  name = "S3AccessPolicy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::my-tf-test-bucket369852",
        "arn:aws:s3:::my-tf-test-bucket369852/*"
      ]
    }
  ]
}
EOF
}
