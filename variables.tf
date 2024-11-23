variable "project_id" {
  description = "ID of the Google Cloud project."
  type        = string
}

variable "project_name" {
  description = "Name of the GCP project."
  type        = string
  default     = "suara-nusa-dev-labs"
}

variable "project_number" {
  description = "Number of the GCS project."
  type        = string
}

variable "region" {
  description = "Region for Google Cloud services."
  type        = string
}

variable "zone" {
  description = "Zone of Google Cloud region."
  type        = string
}

variable "service_account_role" {
  description = "Role for service account"
}


variable "location" {
  description = "Location of the bucket."
  type        = string
  default     = "us-central1"
}

variable "github_personal_access_token" {
  description = "Github personal access token for GitHub."
  type        = string
}


variable "first_time" {
  description = "It is first time to trigger build"
  type        = bool
}

variable "first_time_exec_sql" {
  description = "It is first time to trigger exec sql"
  type        = bool
}

variable "db_alfarezyyd_password" {
  description = "Password for another user"
}