resource "google_cloud_run_v2_job" "default" {
  provider            = google-beta
  name                = "cloudrun-job-scraping-etl"
  location            = var.region
  deletion_protection = false
  template {
    template {
      containers {
        image = var.image_name
      }
    }

  }

}

output "cloud_run_job_name" {
  value = google_cloud_run_v2_job.default.name
}

output "cloud_run_job_location" {
  value = google_cloud_run_v2_job.default.location
}