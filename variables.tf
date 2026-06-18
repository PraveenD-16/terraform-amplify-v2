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
  description = "GitHub branch name to deploy"
  type        = string
  default     = "main"
}

variable "environment" {
  description = "Deployment environment (dev, demo, staging, prod)"
  type        = string
  default     = "demo"

  validation {
    condition     = contains(["dev", "demo", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, demo, staging, or prod."
  }
}

variable "branch_stage" {
  description = "Amplify branch deployment stage"
  type        = string
  default     = "DEVELOPMENT"

  validation {
    condition = contains(
      ["PRODUCTION", "BETA", "DEVELOPMENT", "EXPERIMENTAL", "PULL_REQUEST"],
      var.branch_stage
    )
    error_message = "branch_stage must be one of: PRODUCTION, BETA, DEVELOPMENT, EXPERIMENTAL, PULL_REQUEST."
  }
}

variable "github_token" {
  description = "GitHub Personal Access Token for Amplify source access"
  type        = string
  sensitive   = true
}

variable "owner" {
  description = "Team or individual owning this resource (ISO A.5.9 asset inventory)"
  type        = string
  default     = "DevRepublic"
}

variable "cost_center" {
  description = "Cost center code for financial accountability"
  type        = string
  default     = "PROJ-001"
}
