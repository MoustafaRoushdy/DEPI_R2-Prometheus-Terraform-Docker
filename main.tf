resource "aws_key_pair" "shared_key" {
  key_name   = "shared_server_key"
  public_key = file("~/.ssh/deployer.pub")
}

module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "scripts/install_java.sh"
  web_port = 8080
  key_name    = aws_key_pair.shared_key.key_name
  use_file_provisioner = false
}
module "prometheus_server" {
  source = "./modules/server_module"
  server_name = "Prometheus"
  script_path = "scripts/install_docker.sh"
  web_port = 9090
  key_name    = aws_key_pair.shared_key.key_name
  use_file_provisioner = true
  local_file_path      = "./modules/server_module/config_files/prometheus.yml"
  remote_file_path     = "/home/ubuntu/prometheus.yml"
}
