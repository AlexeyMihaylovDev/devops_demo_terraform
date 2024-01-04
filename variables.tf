
variable "aws_region" {
    description = "value of the region"
    default = "ca-central-1" 
}

variable "aws_cidr_block" {
    description = "value of the cidr block"
    default = "11.0.0.0/24"
  
}

variable "availability_zone" {
    description = "value of the availability zone"
    default = "ca-central-1a"
  
}
variable "tags" {
    description = "value of the tags"
    default = "tf"
  
}
variable "ami" {
    description = "value of the ami"
    default = "ami-0a2e7efb4257c0907"
  
}