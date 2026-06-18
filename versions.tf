terraform {

  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.50"
    }
  }

  # ──────────────────────────────────────────────────────────────
  # Remote Backend (S3 + DynamoDB)
  #
  # IMPORTANT: Uncomment and configure before team or pipeline use.
  # You must first create the S3 bucket and DynamoDB table:
  #   - S3 bucket with versioning and encryption enabled
  #   - DynamoDB table with partition key "LockID" (String)
  # ──────────────────────────────────────────────────────────────
  # backend "s3" {
  #   bucket         = "your-org-terraform-state"
  #   key            = "amplify/terraform.tfstate"
  #   region         = "eu-west-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}
