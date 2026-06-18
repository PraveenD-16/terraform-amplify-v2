output "amplify_app_name" {
  description = "AWS Amplify application name"

  value = aws_amplify_app.demo.name
}

output "amplify_app_id" {
  description = "AWS Amplify application ID"

  value = aws_amplify_app.demo.id
}

output "amplify_default_domain" {
  description = "AWS Amplify default domain"

  value = aws_amplify_app.demo.default_domain
}

output "amplify_branch_name" {
  description = "Amplify branch name"

  value = aws_amplify_branch.main.branch_name
}

output "amplify_branch_arn" {
  description = "Amplify branch ARN"

  value = aws_amplify_branch.main.arn
}
