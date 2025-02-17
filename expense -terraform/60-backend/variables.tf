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