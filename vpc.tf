resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC_Virginia${local.sufix}"
  }
  }

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Subred_publica${local.sufix}"
  }
  }

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "subred_privada${local.sufix}"
  }
  depends_on = [ 
    aws_subnet.public_subnet 
    ]
  }

  resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc_virginia.id

    tags = {
      "name" = "igw virginia${local.sufix}"
    }
  }

  resource "aws_route_table" "public_crtable" {
    vpc_id = aws_vpc.vpc_virginia.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      "name" = "Mi Crt publica${local.sufix}"
    }
  }

  resource "aws_route_table_association" "crta_public_subnet" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_crtable.id
  }

  resource "aws_security_group" "sg_instancia_publica" {
    name = "Instancia publica SG"
    description = "Permitir el trafico SSH de entrada"
    vpc_id = aws_vpc.vpc_virginia.id

   
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = [var.sg_ingress_cidr]
    }
  }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Permitir SSH ${local.sufix}"
    }
  }
