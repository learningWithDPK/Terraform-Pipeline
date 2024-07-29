terraform {
  backend "s3" {
    bucket = "terraform-backend-05062024"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }

  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"  # Specify the version for the template provider
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCx7+zURtRZ4+rn931z91hlFEeog55NktpW2kbU3LpVWThZKDfErgmhh+KIQqs1LtZ/PTMFCWU0ORdeOfH8JFXUHjgDIOa7CTyB2DB9gXzDh9+5tTmmn7AEOAuePiNGEjo1ldxDvQGWO0txhTJPWJ9Lmh61kUeS+50pjS693JzreAntikuWbKQ6zeHow2kpzjvNJg1mBYPrU9Tpl8Plvt2H3oSvC7OmbwxakApPQijWlFjuQNZVPEguV2Qv/zlkkU3BVSILLijkKmEeZiFBTJ5ANM6DdrZorqrdvoDASaxphuPfLw/6HBDbYVonsLgoHFehaI/gH/ZxSsRyZm5N2SxJAeFwsA7RYWtEcijvWboI+LyFO5ZejP19oysFifjWrbwO/LVL3842nbrCeXShI59OvkaF1ejDdW2rT6R3MC7SfkP0prL5+qqc2Vl81tbZ4UnE/SZfDPUU4x/MGe1UvMBg0ljVv/n+uQIo1bkHFNayc2xhKEwfbJNwbu3bbEroqek= dkaushik@DESKTOP-S3KIB7D"
}

data "aws_vpc" "main" {
  id = "vpc-0ab17bcdab8575326"
}

data "template_file" "user_data" {
  template = file("./install_jenkins.sh")
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id 
}

resource "aws_security_group_rule" "allow_http" {
  type        = "ingress"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
}

resource "aws_security_group_rule" "allow_jenkins" {
  type        = "ingress"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
}

resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type        = "egress"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
  owners = ["self", "amazon"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}


output "web_ip" {
  value = aws_instance.Jenkins_testing.public_ip
}
resource "aws_instance" Jenkins_testing {
    count=0
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = "${aws_key_pair.deployer.key_name}"  # we have to use interpolation ${} . thisis used for dynamic configuration
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    user_data = data.template_file.user_data.rendered
    root_block_device {

    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }
  tags = {
    Name = "Jenkins_testing"
  }
}

output "web_ip" {
  value = aws_instance.Jenkins_testing.public_ip
}
