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
    default = "Z0831167G59LP164HRM"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}