provider "google" {
  project = var.project_name
  region  = var.region
}


module "cloud_build" {
  source             = "./modules/cloud-build"
  project_id         = var.project_id
  region             = var.region
  project_number     = var.project_number
  service_account_id = module.service_account.cloudbuild_service_account_id
  github_personal_access_token = var.github_personal_access_token
}

module "container_registry" {
  source     = "./modules/container-registry"
  project_id = var.project_id

}


module "service_account" {
  source               = "./modules/service-account"
  service_account_role = var.service_account_role
  project_id           = var.project_id
}


module "cloud_run" {
  source                   = "./modules/cloud-run"
  cloud_run_service_name   = "crun"
  image_name               = module.cloud_build.suara_nusa_api_image_name
  location                 = var.location
}


# module "cloud_sql" {
#   source = "./modules/cloud-sql"
# }