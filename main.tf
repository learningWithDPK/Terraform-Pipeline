terraform {
  backend "s3" {
    bucket = "terraform-backend-05062024"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}

terraform {
  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
  owners = ["self", "amazon"]
}

resource "aws_instance" "variable_testing" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  availability_zone = "eu-north-1c"
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }
  tags = {
    Name = "provisioner_testing"
  }
  metadata_options {
    http_tokens = "required"
  }
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

output "web_ip" {
  value = aws_instance.variable_testing.public_ip
}
