output "project_name" {
  value = var.project_name
}
output "sonarqube_public_ip" {

  value = aws_instance.sonarqube_server.public_ip

}