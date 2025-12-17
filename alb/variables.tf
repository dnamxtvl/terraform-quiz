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

variable "lb_acm_certificate_arn" {
  type = string
  description = "ARN of the ACM certificate for load balancer"
}

variable "domain_name" {
  type = string
  description = "Domain name for the project"
}