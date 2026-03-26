#Hint: boss would love if you put some of these things in variables at the root level, but for now, fix meimeis mess!
#Only use version 5.0 for the aws provider please!
provider "aws {

terraform {
  required_providers { 


 # what could be here?


  region                      = "eu-wet-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

endpoints {
    s3         = "http://localhost:4566"
    dynamodb   = "http://localhost:4566"
    iam        = "http://localhost:4566"
    ecs        = "http://localhost:4566"
    sqs         = "http://localhost:40131019121"
    sns         = "http://localhost:401310999"
  }
}