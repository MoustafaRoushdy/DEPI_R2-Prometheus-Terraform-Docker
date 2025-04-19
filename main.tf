

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
#   web_port = 9090
#   is_file_copied = true
#   file_name = "prometheus.yml"
# }

module "server1" {
  source = "./modules/server_module"
  server_name = "server1"
  script_path = "./scripts/install_openjdk.sh"
  is_file_copied = false
  use_web_port = false
}

module "server2" {
  source = "./modules/server_module"
  server_name = "server2"
  script_path = "./scripts/install_openjdk.sh"
  is_file_copied = false
  use_web_port = false
}


