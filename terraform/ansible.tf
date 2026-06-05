resource "local_file" "ansible_inventory" {

  filename = "../ansible/inventory.ini"

  content = <<EOF
[sonarqube]
${aws_instance.sonarqube_server.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/2026_key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

}