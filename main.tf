##Definimos Provider

provider "aws" {
  region = "us-west-1"

}

data "aws_subnet" "az_b" {
  availability_zone = "us-west-1b"
  
}


data "aws_subnet" "az_c" {
  availability_zone = "us-west-1c"
  
}


resource "aws_instance" "mi_server1" {
  ami = "ami-0d50e5e845c552faf"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.az_b.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Server_1" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    "Name" = "Server_1"
  }
}

resource "aws_instance" "mi_server2" {
  ami = "ami-0d50e5e845c552faf"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.az_c.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Server_2" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    "Name" = "Server_2"
  }
}

resource "aws_security_group" "Secury_Neza" {
  name = "Mi_Primer_Server"


  ingress {

    cidr_blocks  = ["0.0.0.0/0"]
    description = "Acceso a Busy box"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "TCP"
    
  }
  
}
