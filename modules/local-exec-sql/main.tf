resource "null_resource" "create_database" {
  count = var.first_time ? 1 : 0 # Var first_time adalah boolean yang menentukan apakah ini pertama kali atau tidak.

  provisioner "local-exec" {
    command = <<EOT
      gcloud sql databases create nest_suara_nusa_api \
        --instance=${var.database_instance_name} \
        --charset=utf8 \
        --collation=utf8_general_ci
    EOT
  }
}
