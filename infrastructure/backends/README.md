# Terraform Backend Providers

This project sets up the basic resources required to manage Terraform state without another provider like Spacelift.

## AWS S3

The intent with s3 is to create just enough that authentication can be passed from a manual AWS login to an IAM role assumed with the GitHub Actions OIDC token.

This IAM role is quite limited: it has full IAM permissions, but only enough s3 permissions to work with the bucket that stores the state file.
