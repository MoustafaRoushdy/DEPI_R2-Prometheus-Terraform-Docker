output "prometheus_server_ip" {
  value = aws_instance.server.public_ip 
}