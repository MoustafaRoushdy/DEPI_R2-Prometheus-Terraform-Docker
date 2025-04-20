

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


