terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}


resource "aws_vpc" "development-vpc"{
    cidr_block = var.vpc_cidr_block
    tags = {
      "name" = "development"
      vpc_env ="dev"
    }

}

resource "aws_subnet" "dev-subnet-1"{
    vpc_id =aws_vpc.development-vpc.id
    cidr_block=var.subnet_cidr_block
    availability_zone="us-east-1a"
    tags = {
      "name" = var.environment
    }
}
data "aws_vpc" "existing_vpc"{
  default=true

}

variable "subnet_cidr_block" {
  description = "subnet cidr block"

  
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  
}
variable "environment" {
  description = "deployment"
  
}
resource "aws_subnet" "dev-sunbet-2"{
   vpc_id=data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.96.0/20"
  availability_zone="us-east-1a"
}
output "dev-vpc-id" {
  value=aws_vpc.development-vpc.id
  
}

output "dev-subnet-id" {
  value=aws_subnet.dev-subnet-1.id
}
