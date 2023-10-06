resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket369852"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
