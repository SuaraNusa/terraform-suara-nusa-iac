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

  metadata {
    annotations = {
      # "autoscaling.knative.dev/maxScale" = "1000"
      # "run.googleapis.com/cloudsql-instances" = var.database_connection_name
      "run.googleapis.com/client-name" = "terraform"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}