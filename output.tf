#output "EC2_public_ip" {
#  #count = length(var.instancias)
#  description = "Ip publica de la instancia"
#  #value = aws_instance.public_instance.public_ip
#  #value = var.instancias[count.index].public_ip
#}