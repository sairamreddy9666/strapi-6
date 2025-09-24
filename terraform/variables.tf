variable "aws_region" {
type = string
default = "ap-south-1"
}


variable "env" {
type = string
default = "dev"
}


variable "image_tag" {
type = string
default = "latest"
}


variable "desired_count" {
type = number
default = 1
}


variable "container_port" {
type = number
default = 1337
}
