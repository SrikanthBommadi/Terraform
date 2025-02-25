variable "ami_id" {
    default ="ami-09c813fb71547fc4f"

  
}
variable "instance_type" {  #mandatory
    default = "t3.micro"
    validation {
      condition = contains (["t3.micro","t2.micro","t2.small"],var.instance_type)
      error_message = "you have to choose the specified values mentioned in our condition"
    }
  
}
variable "sg_id" {    #mandatory
  
}


variable "tags" {    #optional
    default = {}
  
}