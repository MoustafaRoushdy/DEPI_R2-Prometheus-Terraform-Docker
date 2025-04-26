data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "server_key" {
  key_name   = "${var.server_name}-key"
  public_key = file("~/.ssh/deployer.pub")
}


resource "aws_security_group" "allow_webport" {
  name        = "${var.server_name}-allow-${var.web_port}"
  description = "Allow ssh and ${var.web_port} traffic and all outbound traffic"

  tags = {
    Name = "allow_ssh_and_${var.web_port}"
  }
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_webport.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_webport.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_web_port" {
  count             = var.enable_web_ingress ? 1 : 0
  security_group_id = aws_security_group.allow_webport.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "${var.web_port}"
  ip_protocol       = "tcp"
  to_port           = "${var.web_port}"
}


resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_webport.id]
  iam_instance_profile = var.instance_profile_name
  tags = {
    Name = "${var.server_name}_server"
  }

}

resource "null_resource" "copy_file" {
  count = "${var.is_file_copied}" ? 1 : 0

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("~/.ssh/deployer")
    host     = aws_instance.server.public_ip
  }

  provisioner "file" {
    source      = "files/${var.file_name}"
    destination = "/home/ubuntu/${var.file_name}"
  }

  depends_on = [ aws_instance.server ]


}

resource null_resource "remote_provisioner" {
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("~/.ssh/deployer")
    host     = aws_instance.server.public_ip
  }

  provisioner "remote-exec" {
    script = "scripts/${var.script_path}"
  }

  depends_on = [ null_resource.copy_file ]
}

resource "null_resource" "fetch_jenkins_admin_password" {
  count = var.server_name == "jenkins" ? 1 : 0

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ~/.ssh/deployer ubuntu@${aws_instance.server.public_ip}:/home/ubuntu/initialAdminPassword ."
  }
  depends_on = [null_resource.remote_provisioner]
}

data "local_file" "jenkins_password" {
  count = var.server_name == "jenkins" ? 1 : 0
  filename = "./initialAdminPassword"
  depends_on = [null_resource.fetch_jenkins_admin_password]
}

resource "aws_key_pair" "jenkins_agent_key" {
  key_name   = "jenkins-agent-key"
  public_key = file("~/.ssh/test.pub")
}


resource "aws_security_group" "jenkins_agent_sg" {
  name        = "jenkins-agent-sg"
  description = "Allow SSH only from Jenkins master SG"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_webport.id]
    description     = "Allow SSH from Jenkins master SG only"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-nodes"
  }
}
