resource "google_secret_manager_secret" "database_url" {
  secret_id = "database_url"
  replication {
    auto {
    }
  }
}

resource "google_secret_manager_secret_version" "database_url_version" {
  secret      = google_secret_manager_secret.database_url.id
  secret_data = "mysql://root:root@localhost/${var.database_name}?socket=/cloudsql/${var.database_connection_name}"
}

resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "jwt_secret_key"
  replication {
    auto {
    }
  }
}

resource "google_secret_manager_secret_version" "jwt_secret_key_version" {
  secret      = google_secret_manager_secret.jwt_secret_key.id
  secret_data = "reallySecretKey"
}

resource "google_secret_manager_secret" "github-token-secret" {
  secret_id = "github-token-secret"

  replication {
    auto {}
  }
}


resource "google_secret_manager_secret_version" "github-token-secret-version" {
  secret      = google_secret_manager_secret.github-token-secret.id
  secret_data = var.github_personal_access_token
}


output "github_token_secret_version_id" {
  value = google_secret_manager_secret_version.github-token-secret-version.id
}

output "jwt_secret_key_id" {
  value = google_secret_manager_secret.jwt_secret_key.secret_id
}

output "database_url_id" {
  value = google_secret_manager_secret.database_url.secret_id
}