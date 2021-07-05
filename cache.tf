data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id

  filter {
    name = "tag:Name"
    values = [
      "private-${var.product}-${var.environment}-0",
      "private-${var.product}-${var.environment}-1"
    ]
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "main-${var.product}-${var.environment}"
  subnet_ids = data.aws_subnet_ids.private.ids

  tags = {
    Name        = "main-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "main-${var.product}-${var.environment}"
  engine               = "redis"
  node_type            = var.cache_instance_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.main.name

  tags = {
    Name        = "main-${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
