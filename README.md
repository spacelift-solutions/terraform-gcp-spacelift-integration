# Spacelift GCP Integration Terraform Module

This Terraform module sets up the necessary Google Cloud Platform (GCP) resources to integrate Spacelift with your GCP project using Workload Identity Federation. This approach provides secure, keyless authentication between Spacelift and GCP without the need to manage service account keys.

## Basic Usage

```hcl
module "spacelift_gcp_integration" {
  source = "github.com/spacelift-solutions/terraform-gcp-spacelift-integration"

  project_id             = "my-gcp-project-id"
  spacelift_account_name = "my-company"  # For my-company.app.spacelift.io
}
```

### Advanced Usage with Custom Configuration

```hcl
module "spacelift_gcp_integration" {
  source = "github.com/spacelift-solutions/terraform-gcp-spacelift-integration"

  project_id             = "my-gcp-project-id"
  spacelift_account_name = "my-company"

  # Custom identity pool configuration
  workload_identity_pool_id           = "custom-spacelift-pool"
  workload_identity_pool_display_name = "Custom Spacelift Identity Pool"
  
  # Custom provider configuration
  workload_identity_pool_provider_id           = "custom-spacelift-provider"
  workload_identity_pool_provider_display_name = "Custom Spacelift Provider"
  
  # Custom service account configuration
  service_account_account_id    = "custom-spacelift-sa"
  service_account_display_name  = "Custom Spacelift Service Account"
}
```

## Input Variables

### Required Variables

| Name | Type | Description |
|------|------|-------------|
| `project_id` | `string` | GCP project ID to integrate Spacelift with |
| `spacelift_account_name` | `string` | Spacelift subdomain (e.g., for `your-subdomain.app.spacelift.io`, use `your-subdomain`). If using this module in Spacelift, this value is automatically injected |

### Optional Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `workload_identity_pool_id` | `string` | `"spacelift"` | Identity pool ID for Spacelift |
| `workload_identity_pool_display_name` | `string` | `"Spacelift"` | Display name for the identity pool |
| `workload_identity_pool_provider_id` | `string` | `"spacelift-io"` | Workload identity pool provider ID |
| `workload_identity_pool_provider_display_name` | `string` | `"Spacelift"` | Display name for the workload identity pool provider |
| `service_account_account_id` | `string` | `"spacelift"` | Service account ID for Spacelift |
| `service_account_display_name` | `string` | `"Spacelift Service Account"` | Display name for the service account |

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure the user/service account running Terraform has sufficient permissions to create IAM resources
2. **API Not Enabled**: Enable the required APIs (IAM API, Cloud Resource Manager API) in your GCP project
3. **Invalid Audience**: Verify that the `spacelift_account_name` matches your actual Spacelift subdomain

### Verification

To verify the setup is working:

1. Check that the workload identity pool was created:

   ```bash
   gcloud iam workload-identity-pools list --location=global
   ```

2. Verify the service account exists:

   ```bash
   gcloud iam service-accounts list
   ```

3. Test the integration by running a Spacelift stack that uses GCP resources

## Contributing

When contributing to this module, please:

1. Follow Terraform best practices
2. Update this README for any new variables or resources
3. Consider the security implications of any changes
4. Test changes thoroughly in a development environment
