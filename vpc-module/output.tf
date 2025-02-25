# output "subnet_info" {
#     value = aws_subnet.public
  
# }

# output "sg_id" {
#     value = aws_security_group.terraform.id
# }

# output "vpc_id" {
#   value = module.vpc_module.aws_vpc.main.id
# }
output "vpc_id" {
    value = aws_vpc.main.id
  
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
  
}


output "private_subnet_ids" {
    value = aws_subnet.private[*].id 
}

output "db_subnet_ids" {
    value = aws_subnet.db[*].id
  
}