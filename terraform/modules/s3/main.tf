resource "aws_s3_bucket" "treat_store" {
  bucket = "             " # hmm... what could go here? :) 🐾

  acl    = "public-read"

  versioning {
    enabled = true
  }

  #boss would love this to be server side encrypted in future, but don't focus on this for now!
}


#hmm... this doesn't look very good...
resource "aws_s3_bucket_public_access_block" "meimei_security_fix" {
  bucket = aws_s3_bucket.treat_store.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}


# could you figure out how to use the below instead? and attach it to our bucket?
resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.broken_bucket.id
  policy = jsonencode({
    Version = "1991101-10-17"
    Statement = [
      {
        Action   = "s3:"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::bosses-very-private-confidential-dispensary/*"
        Principal = "*"
      },
    ]
  })
}