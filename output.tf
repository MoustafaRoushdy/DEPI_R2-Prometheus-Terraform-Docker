output "prometheus_public_ip" {
  value = aws_instance.prometheus_server.public_ip
  description = "Public IP of the Prometheus EC2 instance"
}