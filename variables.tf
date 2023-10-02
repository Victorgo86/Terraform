variable "virginia_cidr" {
    description = "CIDR Virginia"
    type = string
    //sensitive = true
}

variable "subnets" {
  description = "Lista de subredes"
  type = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR para tráfico de entrada"
  type = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type = map(string)
}

variable "enable_monitoring" {
  description = "Llevantar servidor de monitorizacion"
#type = bool
  type = number
}

variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type = list(number)
}