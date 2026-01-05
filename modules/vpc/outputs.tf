output "nat_gateway_public_ip" {
  value       = aws_eip.nat.public_ip
  description = "Public IP của NAT Gateway cho partner whitelist"
}

output "public_subnets" {
  value = [
    for subnet in aws_subnet.public_subnet : {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      route_table_id    = aws_route_table.public.id
    }
  ]
}

output "private_subnets_ecs" {
  value = [
    for subnet in aws_subnet.private_subnet_ecs : {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      route_table_id    = aws_route_table.private.id
    }
  ]
}

output "private_subnets_rds" {
  value = [
    for subnet in aws_subnet.private_subnet_rds : {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      route_table_id    = aws_route_table.private.id
    }
  ]
}

output "private_subnets_elasticache" {
  value = [
    for subnet in aws_subnet.private_subnet_elasticache : {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      route_table_id    = aws_route_table.private.id
    }
  ]
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds.name
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.elasticache.name
}
