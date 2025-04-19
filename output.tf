# output "jenkins_server_public_ip" {
#   description = "Public IP of the Jenkins server"
#   value = module.jenkins_server.server_ip
# }

# output "prometheus_server_public_ip" {
#   description = "Public IP of the Prometheus server"
#   value = module.prometheus_server.server_ip
  
# }

output "server1_public_ip" {
  description = "Public IP of the server 1"
  value = module.server1.server_ip
}

output "server2_public_ip" {
  description = "Public IP of the server 2"
  value = module.server2.server_ip
}