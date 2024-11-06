resource "google_storage_bucket" "suara-nusa-dev-labs-ml-test-1" {
  name          = "suara-nusa-dev-labs-ml-test-1"
  location      = var.region
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


resource "google_storage_bucket_iam_member" "cloud_run_access" {
  bucket = google_storage_bucket.suara-nusa-dev-labs-ml-test-1.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.cloud_run_service_account_email}"  # Ganti dengan email service account Cloud Run
}