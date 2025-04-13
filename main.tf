

module "prometheus_server" {
  source = "./modules/server_module"
  server_name = "prometheus"
  script_path = "install_docker.sh"
  web_port = 9090
  requierd_file = "prometheus.yml"
 }
