provider "aws" {
  region = "us-east-1"

}  

data "aws_subnet" "az_a" {
    availability_zone = "us-east-1a"
}




data "aws_subnet" "az_b" {
    availability_zone = "us-east-1b"
}




 resource "aws_instance" "Server1" {
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG1.id]
  subnet_id              =  data.aws_subnet.az_a.id
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Server1!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
    tags = {
      "Name" = "ServerOne"
    }
       
 }


resource "aws_instance" "Server2" {
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG1.id]
  subnet_id              =  data.aws_subnet.az_b.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hola server2!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
    tags = {
      "Name" = "ServerTwo"
    }
       
 }




resource "aws_security_group" "SG1" {
  name = "Security_grup para load balancer"

  ingress {

    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso al puerto 8080"
    from_port = "8080"
    to_port = "8080"
    protocol = "TCP"
  }
  
}