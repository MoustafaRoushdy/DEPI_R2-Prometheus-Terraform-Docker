

module "jenkins_server" {
  source = "./modules/server_module"
  server_name = "jenkins"
  script_path = "install_jenkins.sh"
  web_port = 8080
  file_name = "jenkins_controller_key"
  is_file_copied = true
  file_path = "/home/ubuntu/.ssh"
  depends_on = [ null_resource.create_key_pair ]
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
  key_name = aws_key_pair.jenkins_key.key_name
}


resource null_resource "create_key_pair" {
  provisioner "local-exec" {
    command = "echo y |ssh-keygen -t rsa -b 4096 -f files/jenkins_controller_key -N ''"
  }
}

resource aws_key_pair "jenkins_key" {
  key_name   = "jenkins_controller_key"
  public_key = file("files/jenkins_controller_key.pub")

  depends_on = [null_resource.create_key_pair]
}


