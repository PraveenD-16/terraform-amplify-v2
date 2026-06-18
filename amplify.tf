locals {
  common_tags = {
    Environment        = var.environment
    Owner              = var.owner
    CostCenter         = var.cost_center
    DataClassification = "Internal"
  }
}

resource "aws_amplify_app" "demo" {

  name         = var.app_name
  repository   = var.repository_url
  access_token = var.github_token

  enable_branch_auto_build    = true
  enable_branch_auto_deletion = true

  environment_variables = {
    NODE_ENV = var.environment == "prod" ? "production" : "development"
  }

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci --cache .npm --prefer-offline
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: dist
        files:
          - '**/*'
      cache:
        paths:
          - .npm/**/*
  EOT

  tags = local.common_tags
}

resource "aws_amplify_branch" "main" {

  app_id      = aws_amplify_app.demo.id
  branch_name = var.branch_name

  framework = "React"
  stage     = var.branch_stage

  enable_auto_build = true

  tags = local.common_tags
}
