output "instance_ip_address_public" {
  value = aws_eip.eip_lab5.public_ip
  
}

output "instance_ip_address_private" {
  value = aws_instance.instance_lab2.private_ip 
}