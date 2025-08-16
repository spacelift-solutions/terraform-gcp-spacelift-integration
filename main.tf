resource "google_iam_workload_identity_pool" "spacelift" {
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.workload_identity_pool_display_name
  description               = "Identity pool for Spacelift"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "spacelift" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.spacelift.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = var.workload_identity_pool_provider_display_name
  description                        = "OIDC identity pool provider for Spacelift"
  disabled                           = false

  attribute_mapping = {
    "google.subject"  = "assertion.sub"
    "attribute.space" = "assertion.spaceId"
  }
  oidc {
    allowed_audiences = ["${var.spacelift_account_name}.app.spacelift.io"]
    issuer_uri        = "https://${var.spacelift_account_name}.app.spacelift.io"
  }
}

resource "google_service_account" "spacelift" {
  account_id   = var.service_account_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "spacelift" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.spacelift.email}"
}

resource "google_service_account_iam_binding" "spacelift" {
  service_account_id = google_service_account.spacelift.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.spacelift.workload_identity_pool_id}/*"
  ]
}
