provider "aws" {
  region = var.region
  profile = var.profile
}

resource "aws_lightsail_instance" "ubuntu_instance" {
  name              = var.instance_name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name = aws_lightsail_key_pair.lg_key_pair.name
  tags = {
    Environment = "Development"
  }
  # user_data = file(var.user_data_path)
}

resource "aws_lightsail_instance_public_ports" "main" {
  instance_name = aws_lightsail_instance.ubuntu_instance.name
  port_info {
    cidrs      = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
  }
port_info {
    cidrs      = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
  }
  port_info {
    cidrs      = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
    protocol   = "tcp"
  }
  port_info {
    cidrs      = ["0.0.0.0/0"]
    from_port  = 8200
    to_port    = 8200
    protocol   = "tcp"
  }
  port_info {
    cidrs      = ["0.0.0.0/0"]
    from_port  = 8201
    to_port    = 8201
    protocol   = "tcp"
  }
}

resource "aws_lightsail_key_pair" "lg_key_pair" {
  name       = "linhtran"
  public_key = file(var.keypair_path)
}