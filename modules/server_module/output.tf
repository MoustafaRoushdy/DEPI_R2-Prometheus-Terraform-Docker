output "node_1_server_public_IP" {
  description = "public_ip of node_1_server"
  value = aws_instance.node_1_server.public_ip
  
}

output "node_2_server_public_IP" {
  description = "public_ip of node_2_server"
  value = aws_instance.node_2_server.public_ip
  
} 
