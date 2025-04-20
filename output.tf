output "jenkins_server_public_ip" {
  description = "Public IP of the Jenkins server"
  value = module.jenkins_server.server_ip
}