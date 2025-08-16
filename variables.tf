variable "project_id" {
  type        = string
  description = "GCP project ID to integrate spacelift with"
}

# variable "gcp_region" {
#   type    = string
#   default = "europe-west4"
# }

variable "spacelift_account_name" {
  type        = string
  description = "Spacelift subdomain. e.g. <your-subdomain>.app.spacelift.io. This is automatically populated if you're using this module in spacelift"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "Identity pool ID for Spacelift"
  default     = "spacelift"
}

variable "workload_identity_pool_display_name" {
  type        = string
  description = "Display name for the identity pool"
  default     = "Spacelift"
}

variable "workload_identity_pool_provider_id" {
  type    = string
  default = "spacelift-io"
}

variable "workload_identity_pool_provider_display_name" {
  type    = string
  default = "Spacelift"
}

variable "service_account_display_name" {
  type    = string
  default = "Spacelift Service Account"
}


variable "service_account_account_id" {
  type    = string
  default = "spacelift"
}
