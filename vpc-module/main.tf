#VPC CREATE HERE
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy = "default"

  tags =merge(
    var.common_tags,
    var.vpc_tags,
  {
    Name = local.resource_name
  }
  )
}

#SUBNETS  PUBLIC CREATE 
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs [count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags=merge(
        var.common_tags,
        var.public_subnet_tags,
        {
           Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }
    )
}

#vpc private 
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs [count.index]
    availability_zone = local.az_names[count.index]

    tags=merge(
        var.common_tags,
        var.private_subnet_tags,
        {
         Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }
    )
}

# databases subnet
resource "aws_subnet" "db" {
    count = length(var.db_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.db_subnet_cidrs [count.index]
    availability_zone = local.az_names[count.index]

    tags=merge(
        var.common_tags,
        var.db_subnet_tags,
        {
          Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }
    )
}

#internet gsteways
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igt_tags,
    {
        Name = local.resource_name
    }
  )
}

#Route-tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_route_table_tags,
    {
        Name = "${local.resource_name}-public"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags =merge(
    var.private_route_table_tags,
    {
        Name = "${local.resource_name}-private"
    }
  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags =merge(
    var.db_route_table_tags,
    {
        Name = "${local.resource_name}-database"
    }
  )
}
# ELASTIC- IP FOR NAT
resource "aws_eip" "nat" {
  domain   = "vpc"
}

# Nat-gateway
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = local.resource_name
    }
  )

  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

#ATTACHING THE NAT AND INTERNET GATEWAY  
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.example.id
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.example.id
}


# ASSSOCIATE WITH THE 

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnet_cidrs)
  subnet_id      = aws_subnet.db[count.index].id  # Use the correct subnet name here
  route_table_id = aws_route_table.database.id
}


