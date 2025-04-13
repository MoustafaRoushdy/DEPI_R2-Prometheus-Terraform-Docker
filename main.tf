# module "prometheus_server" {
#   source = "./modules/server_module"
#   server_name = "promtheus"
#   script_path = "scripts/install_docker.sh"
#   web_port = 9090
#   is_file_copied = true
#   file_name = "files/prometheus.yml"
# }

module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "scripts/install_java.sh"
  web_port = 8080
  is_file_copied = false
}
