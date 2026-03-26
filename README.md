# kitty-terraform-demo

This README is your tool to help temptations HQ restore itself to its former glory! 🐈

As you may already know, Meimei vibecoded the infra with ClickOps (manual clicking in the AWS console). It’s burning down the company (figuratively and literally). 

As Jinx, You have five main checklist tasks that you need to perform in your group (or on your own if no even groups) to ensure big boss doesn't fire you.

1. Fix the general syntax issues with the terraform boilerplate
2. Fix a pesky S3 configuration issue. 
3. Add a bucket policy to your new S3 that's secure and doesn't allow public access!

4. Create a DynamoDB Table ("the treat inventory") with the bosses required attributes (see the file for more detail).
5. Create a basic IAM role and policy that connects to the dynamodb.

## Bonus points if you can do the below two tasks!
6. Create an SNS topic and an SQS queue, and subscribe the queue to the topic.
7. Configure the SQS queue policy so the SNS topic can deliver messages, then publish and receive a test message if you can!

Have a look at the check_progress.sh script if you're confused about namings of resources.

Once done with each checklist task, uncomment the next file and proceed, this allows for the terraform init > terraform plan > terrform apply flow to work fine.

## ⚠️ Honor Code: Please don't use Amazon Q / AI Tools or copy from any other repo for this! StackOverflow and reading through the below terraform docs are allowed, but the big boss wants your work, not amazons!

## 🐾 Start Here (5 mins)

1. Open the project in visual studio code or Rider
2. Make sure you have terraform installed, if not, run the below (assuming you have choco installed)
3. run the following in a cli (or do it via aws configure):
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="eu-west-1"
export AWS_ENDPOINT_URL=http://localhost:4566
```
choco install terraform --pre 
```

If on a linux distro, consult the terraform installation docs, theres some more faff here with GPG keys:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

4. Also the same thing with the aws cli, make sure you have this so scripts can work: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
5. Open a separate terminal, and navigate to src, then run the below (This will install localstack so you can get started with the demo!)
```
docker-compose up -d
```
6. Open another terminal switched to git bash, then navigate to src/scripts
7. Run the checker script:
```
bash check_progress.sh
```

This will help you track your progress throughout!

## 📜 The Cheat Sheet

Make sure all of the localstack resources are running on port 4566, and that your terraform provider is configured to point to this port as well!

## 📄 Relevant Documentation
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
- https://registry.terraform.io/providers/hashicorp/aws/3.29.1/docs/resources/s3_bucket_policy (you don't need the condition here)
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy

(The following site will help you find all of the IAM policies you need, just copy and paste the actions!)

- https://www.awsiamactions.io/

### And for the brave of you:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic

### 🆘 "I’m Stuck!" (Troubleshooting)
```
"Error: Conflicting configuration" → meimei probably left a duplicate resource name in the file, or potentially made a silly syntax issue, consult your documentation a

"Error: 403 Forbidden" → You’re probably trying to talk to the real AWS. Check your provider.tf and make sure it points to http://localhost:4566, you want this as the same port as localstack.

"my resources are named weirdly" → Meimei was a bit of a joker, check the check_progress.sh script to see the exact names of the resources you need to create, and make sure they match!
    
"I want to start over!" → delete terraform.tfstate and terraform init in the terraform directory.
```