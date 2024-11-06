resource "null_resource" "trigger_build" {
  count = var.first_time ? 1 : 0 # Var first_time adalah boolean yang menentukan apakah ini pertama kali atau tidak.

  provisioner "local-exec" {
    command = <<EOT
      gcloud beta builds triggers run ${var.trigger_name} --region=us-central1 --branch=main
    EOT
  }
}