output "instance_ip_address_public" {
  value = aws_lightsail_instance.ubuntu_instance.public_ip_address
}