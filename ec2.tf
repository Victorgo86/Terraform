variable "instancias" {
  description = "Nombre de las instancias"
  type = set(string)
#  default = [ "apache", "mysql", "jumpserver" ]
  default = [ "apache" ]
}


resource "aws_instance" "public_instance" {
#  count = length(var.instancias)
  for_each = var.instancias
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.clave.key_name
  vpc_security_group_ids = [aws_security_group.sg_instancia_publica.id]
  user_data = file("scripts/userdata.sh")
 
  tags = {
  #  "Name" = var.instancias[count.index]
      Name = "${each.value}${local.sufix}"
  }

}

resource "aws_instance" "monitoring_instance" {
# count = var.enable_monitoring ? 1 : 0
  count = var.enable_monitoring == 1 ? 1 : 0
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.clave.key_name
  vpc_security_group_ids = [aws_security_group.sg_instancia_publica.id]
  user_data = file("scripts/userdata.sh")
 
  tags = {
      Name = "Monitoreo${local.sufix}"
  }

}


#variable "cadena" {
#type = string
#default = "ami-123,AMI-AAV,ami-12f"
#}

#variable "palabras" {
#  type = string
#  default = ["hola","como", "estan"]
#}