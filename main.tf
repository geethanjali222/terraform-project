# main.tf

provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "my-first-bucket14752"  
  
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "my-second-bucket3697"  
  
}

# Output the bucket names
output "bucket1_name" {
  value = aws_s3_bucket.bucket1.id
}

output "bucket2_name" {
  value = aws_s3_bucket.bucket2.id
}
