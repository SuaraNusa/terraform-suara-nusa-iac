resource "google_artifact_registry_repository" "suara-nusa-repository" {
  location      = "us-west1"
  repository_id = var.project_id
  description   = "Docker repository for using the schema registry"
  format        = "DOCKER"
}