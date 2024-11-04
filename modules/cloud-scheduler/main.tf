resource "google_cloud_scheduler_job" "job" {
  name             = "trigger-job"
  description      = "test http job"
  schedule         = "0 0 */7 * *"
  time_zone        = "America/New_York"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = "${var.cloud_run_job}/run_etl"
    body = base64encode("{\"foo\":\"bar\"}")
    headers = {
      "Content-Type" = "application/json"
    }
  }
}