resource "aws_iam_user" "iam_user"{
    name = "terraform_user"

}
resource "aws_iam_access_key""key"{
    user = "aws_iam_user.iam_user.name"

}
output "secret_key"{
    value = aws_iam_access_key.key.secret
    sensitive = true
}
output "access_key" {
    value = aws_iam_access_key.key.id 
}
