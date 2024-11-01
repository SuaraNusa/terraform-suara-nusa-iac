resource "google_cloud_run_service" "default" {
  name     = var.cloud_run_service_name
  location = var.location

  template {
    spec {
      containers {
        image = var.image_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}