module "jenkins_node_1" {
  source = "./modules/server_module"
  server_name = "node_1"
  script_path = "install_java.sh"
  web_port = 8080 
}

module "jenkins_node_2" {
  source = "./modules/server_module"
  server_name = "node_2"
  script_path = "install_java.sh"
  web_port = 8080 
}


# module "jenkins_server" {
#   source = "./modules/server_module"
#   server_name = "jenkins"
#   script_path = "install_java.sh"
#   web_port = 8080
# }


# module "prometheus_server" {
#   source = "./modules/server_module"
#   server_name = "prometheus"
#   script_path = "install_docker_prometheus.sh"
#   web_port    = 9090
#   is_file_copied = true
#   file_name = "prometheus.yml"
# }