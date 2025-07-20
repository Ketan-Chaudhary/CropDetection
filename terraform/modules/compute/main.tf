variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_count" {}
variable "instance_type" {}
variable "key_name" {}

# Infra Required
# -> instance 
# -> security group

resource "aws_security_group" "swamr_sg" {
  name        = "swarm-sg"
  description = "Allow Swarm traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Docker swarm manager port
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "swarm-sg"
  }
}

resource "aws_instance" "swarm_nodes" {
  count                  = var.instance_count
  ami                    = "ami-08e5424edfe926b43"
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.swamr_sg.id]

  #Install Docker automatically
  user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                EOF
  tags = {
    Name = "swarm_node-${count.index + 1}"
  }
}

output "instance_public_ips" {
  value = [for instance in aws_instance.swarm_nodes : instance.public_ip]
}
