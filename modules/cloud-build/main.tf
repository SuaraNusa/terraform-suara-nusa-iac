resource "google_cloudbuild_trigger" "trigger-api" {
  name = "trigger-api"

  github {
    owner = "suara-nusa"
    name  = "nest-suara-nusa-api"
    push {
      branch = "main"
    }
  }

  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", "gcr.io/${var.project_id}/suara-nusa-api", "."]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["push", "gcr.io/${var.project_id}/suara-nusa-api"]
    }

    images = ["gcr.io/${var.project_id}/suara-nusa-api"]
  }
}

# Menggunakan data source untuk mengambil informasi image
data "google_container_registry_image" "suara_nusa_api_image" {
  name = "gcr.io/${var.project_id}/suara-nusa-api"
}


output "suara_nusa_api_image_name" {
  value = data.google_container_registry_image.suara_nusa_api_image.name
}