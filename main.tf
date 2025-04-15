module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "scripts/install_java.sh"
  web_port = 8080
  is_file_copied = false
}