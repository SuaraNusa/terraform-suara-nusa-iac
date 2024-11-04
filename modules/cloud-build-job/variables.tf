variable "project_id" {
  description = "Project ID where Terraform is authenticated to run in"
  type        = string
}

variable "github_token_secret_version_id" {
  description = "GitHub Personal Access Token version ID. Required"
  type        = string
}

variable "service_account_id" {
  description = "Id of the service account to use for running"
  type        = string
}

variable "region" {
  description = "Region of the GCS cloud run job"
  type         = string
}