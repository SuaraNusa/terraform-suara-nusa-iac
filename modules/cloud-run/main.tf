resource "google_cloud_run_service" "default" {
  name     = "suara-nusa-instance"
  location = var.region

  template {
    spec {
      containers {
        image = var.image_name
        resources {
          limits = {
            "cpu"    = "1"
            "memory" = "512Mi"
          }
        }
        env {
          name = "DATABASE_URL"
          value_from {
            secret_key_ref {
              name = var.database_url_id
              key  = "latest"  # Menggunakan versi terbaru dari rahasia
            }
          }
        }
        env {
          name = "JWT_SECRET_KEY"
          value_from {
            secret_key_ref {
              name = var.jwt_secret_key_id
              key  = "latest"  # Menggunakan versi terbaru dari rahasia
            }
          }
        }
        env {
          name  = "GOOGLE_CLIENT_ID"
          value = "68022646682-25ckc588cscgnb3bg4g7nipe5bkeger9.apps.googleusercontent.com"
        }
        env {
          name  = "GOOGLE_CLIENT_SECRET_KEY"
          value = "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"
        }
        env {
          name  = "GOOGLE_CLIENT_CALLBACK_URL"
          value = "http://localhost:3000/authentication/google-redirect"
        }
        env {
          name  = "NODE_MAILER_HOST"
          value = "sandbox.smtp.mailtrap.io"
        }
        env {
          name  = "NODE_MAILER_PORT"
          value = "587"
        }
        env {
          name  = "NODE_MAILER_USERNAME"
          value = "a8939388d3a706"
        }
        env {
          name  = "NODE_MAILER_PASSWORD"
          value = "e026d9ce74f41e"
        }
        env {
          name  = "NODE_MAILER_IS_SECURE"
          value = "false"
        }
        env {
          name  = "NODE_MAILER_DEFAULT_ADDRESS"
          value = "admin@suaranusa.com"
        }
        env {
          name  = "NODE_MAILER_APP_NAME"
          value = "SuaraNusa"
        }
      }
      service_account_name = var.service_account_name
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "5"
        "run.googleapis.com/cloudsql-instances" = var.database_connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }

  autogenerate_revision_name = true

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}