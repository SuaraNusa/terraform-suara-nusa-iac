resource "google_cloud_scheduler_job" "job" {
  provider         = google-beta
  name             = "schedule-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  attempt_deadline = "320s"
  region           = var.region
  project          = var.project_id

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${var.cloud_run_job_default_location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_number}/jobs/${var.cloud_run_job_name}:run"
    oauth_token {
      service_account_email = var.cloud_run_job_sa_email
    }
  }


}