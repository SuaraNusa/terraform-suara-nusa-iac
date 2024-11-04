variable "project_id" {
  description = "ID of the Google Cloud project."
  type        = string
}

variable "region" {
  description = "Region for Google Cloud services."
  type        = string
}

variable "branch" {
  description = "Branch to trigger builds on."
  type        = string
  default     = "main"
}

variable "project_number" {
  description = "The project number for Cloud build"
  type        = string
}

variable "service_account_id" {
  description = "Service account ID for Terraform service account."
  type        = string
}

variable "github_token_secret_version_id" {
  description = "Token for the Github runner Github token"
  type        = string
}