resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "main"
  }
}

resource "aws_subnet" "private_subnet_ecs" {
  count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_ecs[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "private-ecs-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_rds" {
  count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_rds[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "private-rds-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_elasticache" {
  count = 2

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_elasticache[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    "Name" = "private-elasticache-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count = 2

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    "Name" = "public-route-table"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each       = { for k, v in aws_subnet.public_subnet : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-single"
  }
}

resource "aws_nat_gateway" "public" {
  depends_on = [aws_internet_gateway.ig]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "nat-gateway-single"
    AZ   = "ap-southeast-1a"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "private-route-table-single"
  }
}

resource "aws_route_table_association" "private_ecs_association" {
  for_each       = { for k, v in aws_subnet.private_subnet_ecs : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_association" {
  for_each       = { for k, v in aws_subnet.private_subnet_rds : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_elasticache_association" {
  for_each       = { for k, v in aws_subnet.private_subnet_elasticache : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private_subnet_rds : subnet.id]

  tags = {
    Name = "RDS DB subnet group"
  }
}

resource "aws_elasticache_subnet_group" "elasticache" {
  name       = "elasticache-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private_subnet_elasticache : subnet.id]
}

# VPC Endpoints for ECR (to pull Docker images from private subnets)
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for subnet in aws_subnet.private_subnet_ecs : subnet.id]
  security_group_ids  = [aws_security_group.vpc_endpoints_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for subnet in aws_subnet.private_subnet_ecs : subnet.id]
  security_group_ids  = [aws_security_group.vpc_endpoints_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for subnet in aws_subnet.private_subnet_ecs : subnet.id]
  security_group_ids  = [aws_security_group.vpc_endpoints_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "cloudwatch-logs-endpoint"
  }
}

# Security group for VPC endpoints
resource "aws_security_group" "vpc_endpoints_sg" {
  name_prefix = "vpc-endpoints-"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-endpoints-sg"
  }
}

# Data source for current region
data "aws_region" "current" {}
