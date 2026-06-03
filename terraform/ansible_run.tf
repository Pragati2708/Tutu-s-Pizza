resource "null_resource" "run_ansible" {

  depends_on = [
    aws_instance.sonarqube_server,
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {

    command = <<EOT
echo "Waiting for SonarQube EC2 to initialize..."
sleep 60

ansible-playbook \
-i ../ansible/inventory.ini \
../ansible/sonarqube.yml
EOT

  }
}