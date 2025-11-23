# Terraform Backend with AWS S3

This project sets up the basic resources required to manage Terraform state without another provider like Spacelift.

This project creates just enough resources that authentication can be passed from a manual AWS login to an IAM role assumed with the GitHub Actions OIDC token.

This IAM role is quite limited: it has full IAM permissions, but only enough s3 permissions to work with the bucket that stores the state file.

#### Terraform `backend` config
```yaml
terraform {
  backend "s3" {
    bucket       = "seanchristians-lab-terraform-state"
    key          = "<stack>/terraform.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
  }
}

```

#### Setup instructions

1. Generate an access key for the AWS console account
1. Authenticate to AWS with the AWS CLI
```zsh
brew install awscli
aws login
aws configure
```
3. Run the following commands
```zsh
cd infrastructure/backend
terraform init
terraform apply
```
4. Assuming all went well, commit the state file to git
