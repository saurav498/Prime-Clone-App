## Create Security Group

resource "aws_security_group" "prime_sg" {
  description = "Security group from Amazon Prime Clone CICD project"
  name = "Jenkins_server_sg"

  ## Port 22 for SSH access
  ingress {
    description = "SSH Port"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for HTTP access
  ingress {
    description = "HTTP Port"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ##Port for HTTPS access
  ingress {
    description = "HTTPS Port"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for ETCD servers access
  ingress {
    description = "ETCD Port"
    from_port = 2379
    to_port = 2380
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for Jenkins server

  ingress {
    description = "Jenkins Port"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for Grafana access
  ingress {
    description = "Grafana Port"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for Prometheus access
  ingress {
    description = "Prometheus Port"
    from_port = 9090
    to_port = 9090
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for Prometheus metrics server
  ingress {
    description = "Prometheus metrics server port"
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for SonarQube access
  ingress {
    description = "SonarQube Port"
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## Port for KubeAPI server
  ingress {
    description = "KubeAPI Port"
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  } 

  ## k8s Ports
  ingress {
    description = "KubeAPI Port"
    from_port = 10250
    to_port = 10260
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ## NodePort access
  ingress {
    description = "K8s NodePort"
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }  
  ## Define outbound rules to allow all
  egress {
    description = "Define outbound rules to allow all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

## Create EC2 instance

resource "aws_instance" "prime_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.prime_sg.id]

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = var.server_name
  }

  provisioner "file" {
    source      = "C:/Users/saura/Documents/setup.sh"
    destination = "/home/ubuntu/setup.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("./cicd_mumbai_key.pem")
      host = self.public_ip
    }
  }
}

resource "null_resource" "run_remote_script" {
  depends_on = [aws_instance.prime_ec2]

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /home/ubuntu/setup.sh",        
        "sudo /home/ubuntu/setup.sh"
     ]

     connection {
       type = "ssh"
       user = "ubuntu"
       private_key = file("./cicd_mumbai_key.pem")
       host = aws_instance.prime_ec2.public_ip
     }
  }
  
}