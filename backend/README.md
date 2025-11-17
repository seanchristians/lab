# Bootstrap the AWS IAM and S3 Resources for Terraform State Management

This project sets up the basic resources required to manage Terraform state from S3 without another provider like Spacelift.

The intent is to create just enough that authentication can be passed from a manual AWS login to an IAM role assumed with the GitHub Actions OIDC token. That IAM role will also give Terraform all the necessary permissions for AWS.
