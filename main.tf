module "node_1_server" {
  source = "./modules/server_module"
  server_name = "node_1"
  script_path = "install_java.sh"
}

module "node_2_server" {
  source = "./modules/server_module"
  server_name = "node_2"
  script_path = "install_java.sh"
}
