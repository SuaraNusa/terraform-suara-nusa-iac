provider "google" {
  project = var.project_name
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
module "cloud_build" {
  source                         = "./modules/cloud-build"
  project_id                     = var.project_id
  region                         = var.region
  project_number                 = var.project_number
  service_account_id             = module.service_account.cloudbuild_service_account_id
  github_token_secret_version_id = module.secret_manager.github_token_secret_version_id
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
#
module "service_account" {
  source         = "./modules/service-account"
  project_number = var.project_number
  project_id     = var.project_id
}

module "cloud_sql" {
  source                 = "./modules/cloud-sql"
  db_alfarezyyd_password = var.db_alfarezyyd_password
}

module "local_exec_sql" {
  source                 = "./modules/local-exec-sql"
  database_instance_name = module.cloud_sql.database_instance_name
  first_time             = var.first_time_exec_sql
  depends_on = [
    module.cloud_sql
  ]
}

module "secret_manager" {
  source                       = "./modules/secret-manager"
  github_personal_access_token = var.github_personal_access_token
  database_connection_name     = module.cloud_sql.database_connection_name
  database_name                = var.database_name
}

output "jwt_secret_key_id" {
  value       = module.secret_manager.jwt_secret_key_id
  description = "ID dari JWT Secret Key"
}

output "database_url_id" {
  value       = module.secret_manager.database_url_id
  description = "ID dari Database URL Secret"
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

module "cloud_storage" {
  source                          = "./modules/cloud-storage"
  cloud_run_service_account_email = module.service_account.cloudbuild_service_account_email
  region                          = var.region
}

module "cloud_build_infer" {
  source                         = "./modules/cloud-build-infer"
  github_token_secret_version_id = module.secret_manager.github_token_secret_version_id
  project_id                     = var.project_id
  project_number                 = var.project_number
  region                         = var.region
  service_account_id             = module.service_account.cloudbuild_service_account_id
}

# module "cloud-build-job" {
#   source                         = "./modules/cloud-build-job"
#   github_token_secret_version_id = module.secret_manager.github_token_secret_version_id
#   project_id                     = var.project_id
#   region                         = var.region
#   service_account_id             = module.service_account.cloudbuild_service_account_id
# }

# module "local-exec-job" {
#   source       = "./modules/local-exec-job"
#   first_time   = true
#   trigger_name = module.cloud-build-job.cloudbuild_trigger_name
# }
#
# module "cloud-run-job" {
#   source     = "./modules/cloud-run-job"
#   region     = var.region
#   image_name = module.cloud-build-job.suara_nusa_scraping_elt_job_name
# }
#
# module "cloud_storage_job" {
#   source                          = "./modules/cloud-storage-job"
#   cloud_run_service_account_email = module.service_account.cloudbuild_service_account_email
#   region                          = var.region
#   depends_on = [module.local-exec-job]
# }

# module "cloud_scheduler" {
#   source                         = "./modules/cloud-scheduler"
#   cloud_run_job_default_location = module.cloud-run-job.cloud_run_job_location
#   cloud_run_job_name             = module.cloud-run-job.cloud_run_job_name
#   project_id                     = var.project_id
#   project_number                 = var.project_number
#   region                         = var.region
#   cloud_run_job_sa_email         = module.service_account.cloudbuild_service_account_email
# }