output "project_name" {
  value = var.project_name
}
output "sonarqube_public_ip" {

  value = aws_instance.sonarqube_server.public_ip

}
output "sonarqube_url" {
  value = "http://${aws_instance.sonarqube_server.public_ip}:9000"
}
output "application_url" {

  description = "Tutus Pizza Application URL"

  value = "http://${aws_lb.tutus_pizza_alb.dns_name}"

}