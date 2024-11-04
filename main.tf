provider "google" {
  project = var.project_name
  region  = var.region
}

module "cloud_build" {
  source                       = "./modules/cloud-build"
  project_id                   = var.project_id
  region                       = var.region
  project_number               = var.project_number
  service_account_id           = module.service_account.cloudbuild_service_account_id
  github_personal_access_token = var.github_personal_access_token
}

module "local-exec" {
  source       = "./modules/local-exec"
  trigger_name = module.cloud_build.cloudbuild_trigger_name
  first_time   = var.first_time
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

module "cloud_sql" {
  source     = "./modules/cloud-sql"
  project_id = var.project_id
}

module "secret_manager" {
  source = "./modules/secret-manager"
}

module "cloud_run" {
  source                   = "./modules/cloud-run"
  database_connection_name = module.cloud_sql.instance_connection_name
  image_name               = module.cloud_build.suara_nusa_api_image_name
  region                   = var.region
  jwt_secret_key_id        = module.secret_manager.jwt_secret_key_id
  database_url_id          = module.secret_manager.database_url_id
  service_account_name     = module.service_account.cloudbuild_service_account_email
}