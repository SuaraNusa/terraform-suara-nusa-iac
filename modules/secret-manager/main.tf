resource "google_secret_manager_secret" "database_url" {
  secret_id = "DATABASE_URL"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "database_url_version" {
  secret      = google_secret_manager_secret.database_url.id
  secret_data = "mysql://root:root@localhost:3306/nest_suara_nusa_api?schema=public"
}

resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "JWT_SECRET_KEY"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "jwt_secret_key_version" {
  secret      = google_secret_manager_secret.jwt_secret_key.id
  secret_data = "reallySecretKey"
}

output "jwt_secret_key_id" {
  value = google_secret_manager_secret.jwt_secret_key.id
}

output "database_url_id" {
  value = google_secret_manager_secret.database_url.id
}