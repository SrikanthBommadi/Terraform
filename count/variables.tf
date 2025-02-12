variable "instances" {
    default = ["C", "B", "A"]
}
variable "zone_id" {
    default = "Z06493483E1T9QGLKUV9H"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = ""
    }
}