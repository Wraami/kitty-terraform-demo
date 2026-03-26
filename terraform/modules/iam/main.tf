# # TASK 4: IAM POLICY FUN!
# resource "aws_iam_role" "treat-di" {
#   name = "$treat-dispenser-role" # boss would love a variable here, but an answer is in check_progress...

#   assume_role_policy = jsonencode({
#     Version = ""
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = "AWS = "arn:aws:iam::000000000000:" # hmm the account looks right, but somethings missing...
#     }]
#   })
# }

# resource "aws_iam_role_policy" "treat_access" {
#   name = "${var.env_naem{TreatAccessPolicy"
#   role = aws_iam_role.. # whats the resource name above this?

#   policy = jsonencode({
#     Version = "2-17" # What year did these versions start...
#     Statement = [{
#       Action   = ["s3:GetObjects", "s3:ListBuckets"] # Consult your actions site!
#       Effect   = "Deny"
#       Resource = ["arn:aws:s3:::bosses-imaginary-bucket/*"] #what could this value be..?
#     }]
#   })
# }