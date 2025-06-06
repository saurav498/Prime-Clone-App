# GET EC2 USER NAME AND PUBLIC IP and PRIVATE IP

output "SERVER-SSH-ACCESS" {
  value = "ubuntu$@{aws_instance.prime_ec2.public_ip}"
}

output "PUBLIC-IP" {
  value = "${aws_instance.prime_ec2.public_ip}"
}  

output "PRIVATE-IP" {
  value = "${aws_instance.prime_ec2.private_ip}"
}