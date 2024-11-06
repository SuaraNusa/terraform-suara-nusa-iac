resource "google_storage_bucket" "auto-expire" {
  name          = "suara-nusa-dev-labs-job"
  location      = "US"
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
  bucket = google_storage_bucket.auto-expire.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.cloud_run_service_account_email}"  # Ganti dengan email service account Cloud Run
}