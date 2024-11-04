

# Membuat koneksi ke GitHub
resource "google_cloudbuildv2_connection" "github_connection" {
  project = var.project_id
  location = "us-central1"  # atau region spesifik seperti "us-central1"
  name    = "suara-nusa-connection"

  github_config {
    app_installation_id = 56674188  # ID instalasi GitHub App
    authorizer_credential {
      oauth_token_secret_version = var.github_token_secret_version_id
    }
  }
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
  location        = "us-central1"
  service_account = var.service_account_id  # Menggunakan akun layanan kustom

  repository_event_config {
    repository = google_cloudbuildv2_repository.repository.id
    push {
      branch = "main"
    }
  }

  build {
    options {
      logging = "CLOUD_LOGGING_ONLY"
    }

    # Step 1: Build Docker image
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build", "-t",
        "${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-dev-labs/suara-nusa-api",
        "."
      ]
    }

    # Step 2: Push Docker image to Artifact Registry
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-dev-labs/suara-nusa-api",
      ]
    }

    images = ["${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-dev-labs/suara-nusa-api"]
  }
  depends_on = [google_cloudbuildv2_repository.repository]
}

# Menggunakan data source untuk mengambil informasi image
data "google_container_registry_image" "suara_nusa_api_image" {
  name = "${var.region}-docker.pkg.dev/${var.project_id}/suara-nusa-dev-labs/suara-nusa-api"
}


output "suara_nusa_api_image_name" {
  value = data.google_container_registry_image.suara_nusa_api_image.name
}

output "cloudbuild_trigger_name" {
  value = google_cloudbuild_trigger.trigger-api.name
}

