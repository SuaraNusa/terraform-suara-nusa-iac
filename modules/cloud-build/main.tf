resource "google_cloudbuild_trigger" "github_trigger" {
  project     = var.project_id
  name        = "github-cloud-build-trigger"
  description = "Trigger build when there is a push to GitHub"

  github {
    owner = var.github_username
    name  = var.repository_name
    push {
      branch = var.branch
    }
  }

  filename = "cloudbuild.yaml"
}
