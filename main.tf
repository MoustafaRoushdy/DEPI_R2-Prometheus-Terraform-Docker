

module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "install_jenkins.sh"
  web_port = 8080
}


