variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "app_name" {
  description = "AWS Amplify application name"
  type        = string
}

variable "repository_url" {
  description = "GitHub repository URL"
  type        = string
}

variable "branch_name" {
  description = "GitHub branch name"
  type        = string
  default     = "main"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "demo"

  validation {
    condition     = contains(["dev", "demo", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, demo, staging or prod."
  }
}

variable "branch_stage" {
  description = "Amplify branch stage"
  type        = string
  default     = "DEVELOPMENT"

  validation {
    condition = contains(
      ["PRODUCTION", "BETA", "DEVELOPMENT", "EXPERIMENTAL", "PULL_REQUEST"],
      var.branch_stage
    )
    error_message = "Invalid Amplify stage."
  }
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

