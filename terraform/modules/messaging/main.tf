# # BONUS TASK (SNS + SQS with IAM Integrations):

# # Create an SNS topic (named scratcher-topic) and an SQS queue (named scratcher queue) with tags, then subscribe the queue to the topic, make sure to use all the bits youve learned!


# resource "aws_sqs_queue_policy" " {
#   queue_url =

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Si
#       "Principal": "*",
#       "Action": "i only want to send messages, can you help me do that?",
#       "Resource": "${.arn}",
#       "Condition": {
#         "ArnEquals": {
#           "aws:SourceArn": "hmm..."
#         }
#       }
#     }
#   ]
# }
# POLICY
# }

