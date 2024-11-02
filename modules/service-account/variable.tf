variable "service_account_role" {
  description = "Role to assign to the service account"
  type = set(string)
}

variable "project_id" {
  description = "GCP Project ID"
  type = string
}