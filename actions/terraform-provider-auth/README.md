This action authenticates with any Terraform providers that it can, based on the provided input variables.

## Supported providers

### AWS

Authenticate to AWS using GitHub Actions OIDC. Must have an IAM role configured to assume via OIDC. Provide the `AWS_ROLE_ARN` variable to use this provider.

### Tailscale

Authenticate to Tailscale using GitHub Actions OIDC. Must set up a test credential to allow login with OIDC. Provide both the `TAILSCALE_AUDIENCE` and `TAILSCALE_CLIENT_ID` variables to use this provider.
