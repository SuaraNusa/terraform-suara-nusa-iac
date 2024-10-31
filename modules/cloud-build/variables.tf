variable "project_id" {
  description = "ID of the Google Cloud project."
  type        = string

}

variable "region" {
  description = "Region for Google Cloud services."
  type        = string
}

variable "repository_name" {
  description = "Name of the GitHub repository."
  type        = string
}

variable "branch" {
  description = "Branch to trigger builds on."
  type        = string
  default     = "main"
}


variable "github_username" {
  description = "Username for Github authentication."
}