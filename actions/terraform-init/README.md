# Run `terraform init` and set up the S3 backend

## Usage
```yaml
steps:
  - name: terraform init
    uses: seanchristians/lab/actions/terraform-init@main
    with:
      aws-role-arn: ${{ env.AWS_ROLE_ARN }}
      stack-path: infrastructure/<stack>
```

## Inputs
| Parameter | Description | Required |
|---|---|---|
| aws-role-arn | AWS IAM Role ARN to assume with the GitHub Actions OIDC token | yes |
| stack-path | Local path to your Terraform code | yes |
