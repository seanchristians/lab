# Terraform Backend Providers

This project sets up the basic resources required to manage Terraform state without another provider like Spacelift.

## AWS S3

The intent with s3 is to create just enough that authentication can be passed from a manual AWS login to an IAM role assumed with the GitHub Actions OIDC token.

This IAM role is quite limited: it has full IAM permissions, but only enough s3 permissions to work with the bucket that stores the state file.

#### Setup instructions

1. Authenticate to AWS with the AWS CLI
2. Authenticate to GitHub with the GitHub CLI
2. Run the following commands
```zsh
cd infrastructure/backends/s3
terraform init
terraform apply -auto-approve
```
3. Assuming all went well, commit the state file to git

#### Usage instructions

Make a copy of [s3.tf](./s3.tf) in the local stack and call it `backend.tf`. Also choose a unique file path (key) to store the stack's `terraform.tfstate` file.
