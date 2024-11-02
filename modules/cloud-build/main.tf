resource "google_project_iam_member" "cloudbuild_sa_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret" "github-token-secret" {
  secret_id = "github-token-secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github-token-secret-version" {
  secret      = google_secret_manager_secret.github-token-secret.id
  secret_data = "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"
}

# Membuat koneksi ke GitHub
resource "google_cloudbuildv2_connection" "github_connection" {
  project = var.project_id
  location = "us-west1"  # atau region spesifik seperti "us-west1"
  name    = "suara-nusa-connection"

  github_config {
    app_installation_id = 56674188  # ID instalasi GitHub App
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github-token-secret-version.id
    }
  }

  depends_on = [
    google_secret_manager_secret_version.github-token-secret-version,
  ]
}

resource "google_cloudbuildv2_repository" "repository" {
  project    = var.project_id
  location   = google_cloudbuildv2_connection.github_connection.location
  remote_uri = "https://github.com/SuaraNusa/nest-suara-nusa-api.git"
  parent_connection = google_cloudbuildv2_connection.github_connection.id  # Pastikan sesuai dengan ID connection
  name       = "suara-nusa-repository"
}


resource "google_cloudbuild_trigger" "trigger-api" {
  name            = "trigger-api"
  location        = "us-west1"
  service_account = var.service_account_id  # Menggunakan akun layanan kustom

  repository_event_config {
    repository = google_cloudbuildv2_repository.repository.id
    push {
      branch = "main"
    }
  }

  build {
    options {
      logging = "NONE"
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build", "-t",
        "${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-labs/suara-nusa-api",
        "."
      ]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-labs/suara-nusa-api",
      ]
    }

    images = ["${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-labs/suara-nusa-api"]
  }
  depends_on = [google_cloudbuildv2_repository.repository]
}

# Menggunakan data source untuk mengambil informasi image
data "google_container_registry_image" "suara_nusa_api_image" {
  name = "gcr.io/${var.project_id}/suara-nusa-api"
}


output "suara_nusa_api_image_name" {
  value = data.google_container_registry_image.suara_nusa_api_image.name
}

