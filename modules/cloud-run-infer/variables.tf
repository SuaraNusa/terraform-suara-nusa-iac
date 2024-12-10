variable "image_name" {
  description = "Name of the docker image to deploy."
  type        = string
}

variable "database_connection_name" {
  description = "Name of the database connection to connect to."
  type        = string
}

variable "region" {
  description = "Region of the cloud run."
  type        = string
}


variable "service_account_name" {
  description = "Name of service account to provision"
  type        = string
}