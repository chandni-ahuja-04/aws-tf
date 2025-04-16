variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

variable "pub_sub_cidr_1" {
  default = "10.0.0.0/26"
}

variable "pub_sub_cidr_2" {
  default = "10.0.0.64/26"
}

variable "pvt_sub_cidr_1" {
  default = "10.0.0.128/26"
}

variable "pvt_sub_cidr_2" {
  default = "10.0.0.192/26"
}

variable "route_cidr" {
  default = "0.0.0.0/0"
}

variable "db_pw" {
  default = "admin@123"
}