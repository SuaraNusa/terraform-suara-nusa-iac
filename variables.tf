variable "github_token" {
  description = "GitHub token for authentication"
  type        = string
  default     = ""  # Pastikan default dikosongkan
}

variable "github_username" {
  description = "GitHub username for authentication"
  type        = string
  default     = ""
}

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
