# Get an OpenID Connect Token from GitHub

See GitHub's [documentation for OpenID Connect](https://docs.github.com/en/actions/concepts/security/openid-connect).

## Inputs
| Parameter | Description | Required |
|---|---|---|
| audience | Audience expected by the OpenID Service Provider. For example `sts.amazonaws.com` for AWS. | yes |

## Outputs
- `oidc-token`: OpenID Connect token from GitHub.

## Usage
```yaml
steps:
  - name: Get OIDC Token for AWS
    id: aws-oidc-token
    uses: seanchristians/lab/github-actions-oidc@main
    with:
      audience: sts.amazonaws.com

  - name: Login to AWS
    env:
      WEB_IDENTITY_TOKEN: ${{ steps.aws-oidc-token.outputs.oidc-token }}
    ...
```
