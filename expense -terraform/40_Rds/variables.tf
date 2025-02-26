variable "environment" {
    default = "developer"
  
}
variable "project_name" {
    default = "terraform"
  
}
variable "common_tags" {
    default = {
        Project = "terraform"
        Environment = "developer"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z06493483E1T9QGLKUV9H"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}