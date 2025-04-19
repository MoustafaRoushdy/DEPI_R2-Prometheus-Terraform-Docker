output "public_ip" {
  description = "public_ip of node_1_server"
  value = aws_instance.server.public_ip
  
}
