variable "cidr_vpc" {
  description = "CIDR for our VPC"
  default     = "10.1.0.0/16"
}
variable "environment" {
  description = "Environment of the resources"
  default     = "Dev"
}
variable "cidr_public_subnet_a" {
  description = "Subnet fot the public subnet"
  default     = "10.1.1.0/24"
}
variable "cidr_public_subnet_b" {
  description = "Subnet fot the public subnet"
  default     = "10.1.2.0/24"
}
variable "cidr_app_subnet_a" {
  description = "Subnet fot the private subnet"
  default     = "10.1.3.0/24"
}
variable "cidr_app_subnet_b" {
  description = "Subnet fot the private subnet"
  default     = "10.1.4.0/24"
}
variable "az_a" {
  description = "Availablilty zone for the subnet"
  default     = "ap-southeast-2a"
}
variable "az_b" {
  description = "Availablilty zone for the subnet"
  default     = "ap-southeast-2b"
}