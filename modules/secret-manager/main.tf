resource "google_secret_manager_secret" "database_url" {
  secret_id = "DATABASE_URL"
  replication {
    auto {
    }
  }
}

resource "google_secret_manager_secret_version" "database_url_version" {
  secret      = google_secret_manager_secret.database_url.id
  secret_data = "mysql://root:root@localhost:3306/nest_suara_nusa_api?schema=public"
}

resource "google_secret_manager_secret" "jwt_secret_key" {
  secret_id = "JWT_SECRET_KEY"
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
  value = google_secret_manager_secret.jwt_secret_key.id
}

output "database_url_id" {
  value = google_secret_manager_secret.database_url.id
}