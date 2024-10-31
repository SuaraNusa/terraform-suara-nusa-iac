resource "google_service_account" "service_account" {
  account_id                   = "terraform-service-account"
  display_name                 = "Terraform Service Account"
  description                  = "Service account for terraform"
  create_ignore_already_exists = true
}

resource "google_service_account_iam_binding" "storage-object-admin" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.service_account.email}", // Menggunakan service account itu sendiri
  ]
}

resource "google_service_account_iam_binding" "cloud-run-admin" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/run.admin"

  members = [
    "serviceAccount:${google_service_account.service_account.email}", // Menggunakan service account itu sendiri
  ]
}