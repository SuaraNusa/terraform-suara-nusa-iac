variable "region" {
  description = "Google Cloud region"
  default     = "us-central1"
}

variable "db_instance_name" {
  description = "Google Cloud db instance name"
  default     = "minimal-sql-instance"
}

variable "db_root_password" {
  description = "Password untuk user root MySQL"
  default     = "root"
  sensitive   = true
}

variable "db_alfarezyyd_password" {
  description = "Password for another user"
  sensitive   = true
}