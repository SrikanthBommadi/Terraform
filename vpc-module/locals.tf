locals{
    resource_name = "${var.project_name}-${var.environment}"
    az_names = slice(data.aws_availability_zones.available.names, 0, 2)
    default_vpc_id = data.aws_vpc.default.id
    default_vpc_cidr =data.aws_vpc.default.cidr_block
}

# slice(list, start_index, end_index)


# locals {
#   my_list = ["a", "b", "c", "d", "e"]
# }

# output "slice_example" {
#   value = slice(local.my_list, 1, 4)
# }
