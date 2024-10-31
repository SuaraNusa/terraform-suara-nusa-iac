resource "google_service_account" "service_account" {
  account_id                   = "terraform-service-account"
  display_name                 = "Terraform Service Account"
  description                  = "Service account for terraform"
  create_ignore_already_exists = true
}

resource "google_service_account_iam_binding" "service_account_binding" {
  for_each           = var.service_account_role
  service_account_id = google_service_account.service_account.name
  role               = each.value

  members = [
    "serviceAccount:${google_service_account.service_account.email}", // Menggunakan service account itu sendiri
  ]
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.email
}

output "service_account_key" {
  value = google_service_account_key.service_account_key.private_key
}

output "service_account_email" {
  value = google_service_account.service_account.email
}