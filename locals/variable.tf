variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "description"
}

variable "project" {
    default = "A"
}

variable "component" {
    default = "B"
}

variable "environment" {
    default = "C"
}
