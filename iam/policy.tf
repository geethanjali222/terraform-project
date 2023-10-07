resource "aws_iam_user_policy" "iam"{
    name = "demo_policy"
    user = aws_iam_user.iam_user.name

    policy = <<EOF
{
        "Version":"2012-10-17",
        "Statement":[
        {
        "Effect":"Allow",
        "Action":"s3:ListAllMyBuckets",
        "Resource":"*"
        }
        ]
}
EOF
}