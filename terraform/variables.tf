variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "Noname"
}

variable "name_pref" {
  description = "Prefix for all names in name tag"
  type        = string
  default     = "-"
}

variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "Noname"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pub_net_cidrs" {
  description = "Public subnet CIDR"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "priv_net_cidrs" {
  description = "Public subnet CIDR"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "credential_path" {
  description = "Path to credential file"
  type        = string
  default     = "$HOME/.aws/credentials"
}

variable "aws_cli_profile" {
  description = "Profile name in AWS CLI credential and config file"
  type        = string
  default     = "default"
}

variable "ec2_ami_id" {
  description = "AWS ami id"
  type        = string
  default     = "ami-0e1c5be2aa956338b" //AWS Linux 2023 x86_64  
}

variable "ec2_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro" // Free tier
}

variable "availability_zones" {
  description = "azs"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "webserver_pub_key" {
  description = "SSH publick key for access to webserver host"
  type        = string
  default     = "Noname"
}

variable "allowed_ip" {
  description = "Allowed IP addresses to connect webserver"
  type        = list(string)
  default     = []
}

variable "allowed_ports" {
  description = "Allowed ports to connect webserver"
  type        = list(number)
  default     = [22, 80]
}

variable "user_name" {
  description = "username to login"
  type        = string
  default     = "nobody"
}

variable "user_path" {
  description = "Path for a user"
  type        = string
  default     = "/"
}