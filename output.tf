output "jenkins_server_public_ip" {
  description = "Public IP of the Jenkins server"
  value       = module.jenkins_server.server_ip
}

# output "prometheus_server_public_ip" {
#   description = "Public IP of the Prometheus server"
#   value = module.prometheus_server.server_ip

# }

# output "jenkins_node_public_ips" {
#   description = "Public IPs of the Jenkins nodes"
#   value = [for i,instance in module.jenkins_node : "node_${i}: ${instance.server_ip}"]
# }

output "jenkins_admin_password" {
  value = module.jenkins_server.jenkins_admin_password
}