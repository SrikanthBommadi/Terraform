variable "instances" {
    type = map
    default = {
        mysql = "t3.small"
        backend = "t3.micro"
        frontend = "t3.micro"

    }
}
variable "zone_id" {
    default = "Z06493483E1T9QGLKUV9H"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}