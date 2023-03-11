provider "aws" {
  region = "us-east-1"
  
}
 resource "aws_instance" "Server1" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  tags = {
    "name" = "Server_one"
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