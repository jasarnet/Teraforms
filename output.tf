
output "dns_public" {
  value = "http://${aws_instance.Server1.public_dns}:8080/"
}

