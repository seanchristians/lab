# Terraform Backend with AWS S3

> [!CAUTION]
> Local Terraform state file in version control.
>
> This code bootstraps the AWS resources required for other stacks to manage their state remotely.

#### Terraform `backend` config

```hcl
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
