output "prometheus_server_public_ip" {
    value = aws_instance.prometheus_server.public_ip
}