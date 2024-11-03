# Membuat Instance Cloud SQL
resource "google_sql_database_instance" "minimal_instance" {
  name             = var.db_instance_name
  database_version = "MYSQL_8"
  region           = var.region

  settings {
    tier = "db-f1-micro"  # Tier minimum untuk Cloud SQL MySQL
    availability_type = "ZONAL"      # Mode minimum untuk menghemat biaya
    backup_configuration {
      enabled = false               # Nonaktifkan backup untuk konfigurasi minimum
    }
  }
}

# Membuat user root dan menetapkan password
resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.minimal_instance.name
  password = var.db_root_password
}

output "instance_connection_name" {
  value = google_sql_database_instance.minimal_instance.connection_name
}

output "instance_ip_address" {
  value = google_sql_database_instance.minimal_instance.public_ip_address
}
