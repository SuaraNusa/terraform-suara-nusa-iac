variable "cloud_run_job_default_location" {
  description = "Default region for CloudRun job"
  type        = string
}

variable "region" {
  description = "Region for Cloud Run job"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project where to deploy Cloud scheduler"
  type        = string
}

variable "project_number" {
  description = "Google Cloud project number"
  type        = string
}

variable "cloud_run_job_name" {
  description = "Google Cloud Run job name. This needs to be unique in the region to create the host."
  type        = string
}

variable "cloud_run_job_sa_email" {
  description = "Cloud Run service account email"
  type         = string
}