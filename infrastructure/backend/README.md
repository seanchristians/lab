# Terraform Backend with AWS S3

> [!CAUTION]
> Local Terraform state file in version control.
>
> This code bootstraps the AWS resources required for other stacks to manage their state remotely.

### Provider authentication

1. Generate an access key for the AWS console account
1. Authenticate to AWS with the AWS CLI

```zsh
brew install awscli
aws login
```

2. Authenticate to GitHub with the GitHub CLI

```zsh
brew install gh
gh auth login
```

### Update state

```zsh
cd infrastructure/backend
terraform init
terraform apply
```

Assuming all went well, commit the state file to git
