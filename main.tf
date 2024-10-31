provider "google" {
  project = "suara-nusa-labs"
  region  = "us-west1" // Jakarta
}

provider "github" {
  token = var.github_token
  owner = var.github_username
}

module "cloud_build" {
  source          = "./modules/cloud-build"
  github_username = var.github_username
  project_id      = var.project_id
  region          = var.region
  repository_name = var.repository_name
}

