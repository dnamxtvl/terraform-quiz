variable "vpc" {
  type = any
}

variable "sg" {
  type = any
}

variable "container_nginx_port" {
  type    = number
  default = 80
}