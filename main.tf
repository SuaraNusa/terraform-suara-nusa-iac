provider "google" {
  project = "suaranusa-labs"
  region  = "us-west1" // Jakarta
}

provider "github" {
  token = var.github_token
  owner = var.github_username
}

