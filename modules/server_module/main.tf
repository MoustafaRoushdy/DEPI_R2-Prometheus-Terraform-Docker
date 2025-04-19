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
  public_key = file("~/.ssh/id_rsa.pub")

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
  security_group_id = aws_security_group.allow_webport.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "${var.web_port}"
  ip_protocol       = "tcp"
  to_port           = "${var.web_port}"
}


resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_webport.id]
  tags = {
    Name = "${var.server_name}_server"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    script = "scripts/${var.script_path}"
  }


}

