variable "sg_tags" {
    default = {}
  
}

variable "project_name" {
    default = "terraform"
}

variable "environment"{
    default = "developer"
}

variable "common_tags" {
    default = {
        Project = "srikanth"
        Environment = "terraform"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z06493483E1T9QGLKUV9H"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}