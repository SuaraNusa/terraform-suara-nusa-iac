variable "cloud_run_service_account_email" {
  description = "The service account that is used by the CloudRun service"
  type        = string
}

variable "region" {
  description = "Region for GCS"
  type = string
}