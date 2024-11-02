provider "google" {
  project = var.project_name
  region  = var.region// Jakarta
}

# provider "github" {
#   token = var.github_token
#   owner = var.github_username
# }

module "cloud_build" {
  source          = "./modules/cloud-build"
  github_username = var.github_username
  project_id      = var.project_id
  region          = var.region
  repository_name = var.repository_name
}

module "container_registry" {
  source       = "./modules/container-registry"
  project_name = var.project_name
}


# module "service_account" {
#   source               = "./modules/service-account"
#   service_account_role = var.service_account_role
# }



# module "cloud_run" {
#   source                 = "./modules/cloud-run"
#   cloud_run_service_name = "crun"
#   image_name             = module.cloud_build.suara_nusa_api_image_name
#   location               = var.location
# }

#
# module "cloud_sql" {
#   source = "./modules/cloud-sql"
# }