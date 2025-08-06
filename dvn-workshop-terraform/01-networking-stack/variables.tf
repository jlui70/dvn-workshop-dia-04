variable "tags" {
  type = map(string)
  default = {
    Project     = "terraform-devops-project"
    Environment = "production"
  }
}

variable "auth" {
  type = object({
    assume_role_arn = string
    region          = string
  })

  default = {
    assume_role_arn = "arn:aws:iam::794038226274:role/workshop-role"
    region          = "us-east-1"
  }
}

variable "vpc" {
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    public_route_table_name  = string
    private_route_table_name = string
    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    name                     = "devopsproject-vpc"
    cidr_block               = "10.0.0.0/24"
    internet_gateway_name    = "devopsproject-internet-gateway"
    nat_gateway_name         = "devopsproject-nat-gateway"
    public_route_table_name  = "devopsproject-public-route-table"
    private_route_table_name = "devopsproject-private-route-table"
    public_subnets = [{
      name                    = "devopsproject-vpc-public-subnet-1a"
      cidr_block              = "10.0.0.0/26"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      },
      {
        name                    = "devopsproject-vpc-public-subnet-1c"
        cidr_block              = "10.0.0.64/26"
        availability_zone       = "us-east-1c"
        map_public_ip_on_launch = true
    }]
    private_subnets = [{
      name                    = "devopsproject-vpc-private-subnet-1a"
      cidr_block              = "10.0.0.128/26"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
      },
      {
        name                    = "devopsproject-vpc-private-subnet-1c"
        cidr_block              = "10.0.0.192/26"
        availability_zone       = "us-east-1c"
        map_public_ip_on_launch = false
    }]
  }
}