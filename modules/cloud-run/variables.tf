variable "image_name" {
  description = "Name of the docker image to deploy."
  type        = string
}

variable "location" {
  description = "Location of the container registry to provision."
  type         = string
}

variable "cloud_run_service_name" {
  description = "Name of the cloud service."
  type        = string
}

# variable "database_connection_name" {
#   description = "Name of the database connection."
#   type        = string
# }