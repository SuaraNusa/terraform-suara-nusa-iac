# Variabel untuk memudahkan konfigurasi
variable "project_id" {
  description = "Google Cloud project ID"
}

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