provider "aws" {
  region = "aws"

}

resource "aws_security_group" "SG1" {
  name = "Security grup para load balancer"

  ingress {

    cidr_blocks = "0.0.0.0/0"
    description = "acceso al puerto 8080"
    from_port = "8080"
    to_port = "8080"
    protocol = "TCP"
  }
  
}