# Terraform AWS Amplify — Orqestra Insight Hub

Infrastructure-as-Code for deploying the [Orqestra Insight Hub](https://github.com/DevRepublic-NL/orqestra-insight-hub-new) frontend application on **AWS Amplify**.

## Architecture

| Resource | Purpose |
|---|---|
| `aws_amplify_app` | Hosts the React frontend with CI/CD from GitHub |
| `aws_amplify_branch` | Deploys a specific branch with environment-appropriate stage |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) `~> 1.7`
- AWS CLI configured with appropriate credentials
- A GitHub Personal Access Token (PAT) with `repo` scope

## File Structure

```
terraform-amplify-v2/
├── amplify.tf                  # Amplify app + branch resources
├── provider.tf                 # AWS provider configuration
├── variables.tf                # Input variable definitions
├── versions.tf                 # Terraform & provider version constraints
├── outputs.tf                  # Output value definitions
├── terraform.tfvars.example    # Example variable values (copy to terraform.tfvars)
├── envs/                       # Environment-specific variable files
│   ├── dev.tfvars.example
│   ├── staging.tfvars.example
│   └── prod.tfvars.example
├── .gitignore                  # Excludes secrets, state, and provider binaries
└── .terraform.lock.hcl         # Provider version lock (committed)
```

## Quick Start

1. **Clone the repository:**

   ```bash
   git clone <repo-url>
   cd terraform-amplify-v2
   ```

2. **Create your variable file:**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. **Set the GitHub token (never put this in a file):**

   ```bash
   # Linux / macOS
   export TF_VAR_github_token="ghp_your_token_here"

   # Windows PowerShell
   $env:TF_VAR_github_token = "ghp_your_token_here"
   ```

4. **Initialize and deploy:**

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Deploy to a Specific Environment

```bash
# Copy the example file for your target environment
cp envs/dev.tfvars.example envs/dev.tfvars

# Edit with your values
# Then deploy with environment-specific vars
terraform apply -var-file="envs/dev.tfvars"
```

## Environments

| Environment | Branch | Stage | Variable File |
|---|---|---|---|
| Development | `develop` | `DEVELOPMENT` | `envs/dev.tfvars.example` |
| Staging | `main` | `BETA` | `envs/staging.tfvars.example` |
| Production | `main` | `PRODUCTION` | `envs/prod.tfvars.example` |

## Security Notes

> **⚠️ Important**: Follow these practices to keep your infrastructure secure.

- **Never commit `terraform.tfvars`** — it is gitignored by default.
- **Never hardcode the GitHub token** — always use `TF_VAR_github_token` env var.
- **Rotate your PAT** immediately if it was ever committed to git history.
- For production use, consider replacing the PAT with [AWS CodeStar Connections](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections.html).

## Outputs

| Output | Description |
|---|---|
| `amplify_app_name` | Amplify application name |
| `amplify_app_id` | Amplify application ID |
| `amplify_default_domain` | Auto-assigned `.amplifyapp.com` domain |
| `amplify_branch_name` | Deployed branch name |
| `amplify_branch_arn` | Deployed branch ARN |

## Production Readiness Checklist

- [ ] Configure S3 + DynamoDB remote backend in `versions.tf`
- [ ] Replace GitHub PAT with AWS CodeStar Connection
- [ ] Add `aws_amplify_domain_association` for custom domain with SSL
- [ ] Add CI/CD pipeline (GitHub Actions / Azure DevOps)
- [ ] Add basic auth for non-production Amplify apps
- [ ] Add CloudWatch monitoring and alerting
