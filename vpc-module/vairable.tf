 variable "project_name" {
      
    }
variable "environment" {
  
}


#########VPC AND VPC-TAGS
variable "vpc_cidr" {

}

variable "enable_dns_hostnames" {
  default = true
}

variable "vpc_tags" {
  default = {}
}

variable "common_tags" {
    type = map
}


#######SUBNETS AND TAGS
variable "public_subnet_cidrs" {
    type = list
    validation {
      condition =length(var.public_subnet_cidrs) == 2
      error_message = "use the 2 subnets only"
 }

}

variable "public_subnet_tags" {
    default = {}
  
}

variable "private_subnet_cidrs" {
    type = list
    validation {
      condition = length(var.private_subnet_cidrs) == 2
      error_message = "you have to take two only"
    }

}
variable "private_subnet_tags" {
    default = {}
  
}

variable "db_subnet_cidrs" {
    type = list
    validation {
      condition = length(var.db_subnet_cidrs) == 2
     error_message = "only 2 please "
    }
}
variable "db_subnet_tags" {
  default = {}
}

#######ROUTE TABLE
variable "public_route_table_tags" {
    default = {}
  
}
variable "private_route_table_tags" {
    default = {}
  
}
variable "db_route_table_tags" {
    default = {}
  
}

#######INTERNET GATEWAYS
variable "igt_tags" {
    default = {}
  
}

variable "nat_gateway_tags" {
    default = {}
  
}

######vpc peering 

variable "is_peering_required" {
    default = false
  
}
variable "vpc_peering_tags" {
    default = {}
  
}

# ### security groups next class 
# variable "sg_name" {
  
# }

# variable "sg_description" {
  
# }

# variable "sg_tags" {
#     default = {} 
# }