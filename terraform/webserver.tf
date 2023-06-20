resource "aws_instance" "webserver" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.webserver_public_access.id]
  key_name               = aws_key_pair.webserver.key_name

  user_data = <<EOF
                  #! /bin/bash
                  sudo yum install -y update
                  sudo yum install -y yum-utils
                  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
                  sudo yum install -y docker-ce docker-ce-cli containerd.io
                  sudo systemctl start docker
                  sudo usermod -aG docker ec2-user
                  docker run -p 80:80 -n weatherapp_ dmytro108/weatherapp
              EOF

  tags = {
    "Name" = "${var.name_pref}server"
  }
}

resource "aws_eip" "webserver_ip" {
  instance = aws_instance.webserver.id
  domain   = "vpc"
}

resource "aws_security_group" "webserver_public_access" {
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = toset(var.allowed_ports)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_ip
    }
  }

  dynamic "egress" {
    for_each = toset(var.allowed_ports)
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    "Name" = "${var.name_pref}rules"
  }
}