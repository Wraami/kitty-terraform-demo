# TASK 4: IAM POLICY FUN!
resource "aws_iam_role" "tre" {
  name = "${var.env_name}-Treat-Dispenser-Role"

  assume_role_policy = jsonencode({
    Version = ""
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "broken-kitty.amazonaws.com" } # hmm...
    }]
  })
}

resource "aws_iam_role_policy" "treat_access" {
  name = "${var.env_naem{TreatAccessPolicy"
  role = aws_iam_role.bouncer.

  policy = jsonencode({
    Version = "2-17"
    Statement = [{
      Action   = ["s3:GetObjects", "s3:ListBuckets"]
      Effect   = "Deny"
      Resource = ["arn:aws:s3:::bosses-imaginary-bucket/*"] #what could this value be..?
    }]
  })
}