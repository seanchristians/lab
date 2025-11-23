# Login to Tailscale with OpenID Connect (workload identity federation)

This action requests an OIDC token from GitHub scoped to your GitHub Actions runner. It also sets the required environment variables to allow Terraform to login seamlessly.

## 1. Tailscale setup
Follow [Tailscale's instructions](https://tailscale.com/kb/1581/workload-identity-federation) to set up an OIDC trust credential.
- Choose GitHub as the Issuer
- A good subject pattern to start with could be just the name of your repo, for example `repo:seanchristians/lab:*`

## 2. GitHub Action usage
### Parameters
| Parameter | Description | Required |
|---|---|---|
| client-id | Your Tailscale OIDC Federated Identity Client ID | yes |
| audience | Your Tailscale OIDC Federated Identity Audience | yes |

```yaml
steps:
  - name: Tailscale Login
    uses: seanchristians/lab/actions/tailscale-login@main
    with:
      client-id: [your trust credential Client ID]
      audience: [your trust credential Audience]
```

## 3. Terraform setup
```yaml
terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = <version>
    }
  }
}

provider "tailscale" {
  user_agent = "Terraform / seanchristians/lab"
}
```
