

module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "install_jenkins.sh"
  web_port = 8080
}


module "prometheus_server" {
  source = "./modules/server_module"
  server_name = "prometheus"
  script_path = "install_docker_prometheus.sh"
  web_port = 9090
  is_file_copied = true
  file_name = "prometheus.yml"
}


module "jenkins_node" {
  count = 2
  source = "./modules/server_module"
  server_name = "jenkins_node_${count.index}"
  script_path = "install_java.sh"
  enable_web_ingress = false
  depends_on = [module.jenkins_server]
}