resource "google_cloud_run_v2_job" "default" {
  provider            = google-beta
  name                = "cloudrun-job-scraping-etl"
  location            = var.region
  deletion_protection = false
  template {
    template {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/job"
      }
    }
  }
}