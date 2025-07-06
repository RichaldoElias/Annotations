variable "vpc_id" {
  type = string
  description = "The ID of the VPC where the database will be created."
}

variable "db_username" {
  type = string
  default = "admin_user"
}

variable "allocated_storage" {
  type    = number
  default = 10
  description = "The amount of storage (in GB) to allocate for the database."
  
}

variable "db_passord" {
  type = string
}


variable "db_port" {
  type    = number
  default = 3306
}

variable "db_password" {
  type      = string
  sensitive = true
}


variable "aws_region" {
    type    = string
    default = "us-east-1"
}

variable "engine" {
    type    = string
    default = "mysql"
}

variable "instance_class" {
    type    = string
}