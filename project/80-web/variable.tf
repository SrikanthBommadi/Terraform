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
    default = "Z0831167G59LP164HRM"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}