resource "aws_s3_bucket" "buck-terraform-davidsito" {
  bucket = "buck-terraform-davidsito"

  tags = {
    Name        = "buk-terrafm"
    Environment = "Dev"
  }
}