# Secrets Management Instructions

## Tailscale

### Revoke credentials
1. Go to [Trust credentials](https://login.tailscale.com/admin/settings/trust-credentials) in Tailnet settings
1. Find the client with description "Spacelift"
1. Click the three dots on the right and revoke it
### Create a new OAuth client
1. Click on "+ Credential" and follow the instructions
1. Include all permissions
1. Copy the client id and secret
### Upload to Spacelift
1. Go to the [tailscale stack environment](https://seanchristians.app.spacelift.io/stack/tailscale/environment)
1. Update "TF_VAR_tailscale_oauth_client_id" and "TF_VAR_tailscale_oauth_client_secret" with the new values
