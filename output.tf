output "jenkins_node1_public_ip" {
  description = "Public IP of the Jenkins node 1"
  value = module.jenkins_node_1.server_ip
}

output "jenkins_node2_public_ip" {
  description = "Public IP of the Jenkins node 2"
  value = module.jenkins_node_2.server_ip
  
}
