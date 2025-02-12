resource "aws_vpc_peering_connection" "default" {
  peer_vpc_id   = local.default_vpc_id    #acceptor which is default
  vpc_id        = aws_vpc.main.id         #reciever
  auto_accept   = true
  count = var.is_peering_required ? 1  : 0  #this is to choose the yes or no only 

  tags = merge(
    var.common_tags,
    var.vpc_peering_tags,
{
    Name = "${local.resource_name}-default"
  }
  )
}

resource "aws_route" "public-peering" {
    count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "private-peering" {
    count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}



resource "aws_route" "db-peering" {
    count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}


resource "aws_route" "default-peering" {
    count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.main.route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}
































resource "aws_vpc" "foo" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc" "bar" {
  cidr_block = "10.2.0.0/16"
}