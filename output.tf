output "jenkins_server_public_ip" {
  description = "Public IP of the Jenkins server"
  value = module.jenkins_server.server_ip
}

output "prometheus_server_public_ip" {
  description = "Public IP of the Prometheus server"
  value = module.prometheus_server.server_ip
  
}