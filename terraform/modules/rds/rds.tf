
resource "aws_vpc" "rds_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = "${var.firm_id_key}-vpc"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.firm_id_key}-public-subnet-${count.index + 1}"
      Environment = var.environment
    },
    var.tags
  )
}


# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = {
    Name = "${var.firm_id_key}-igw"
  }
}

# Create route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.rds_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.firm_id_key}-public-rt"
  }
}

# Associate route table with subnets
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.firm_id_key}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.rds_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.firm_id_key}-rds-sg"
  }
}

# Create DB subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.firm_id_key}-subnet-group"
  subnet_ids = aws_subnet.public[*].id

  tags = {
    Name = "${var.firm_id_key}-subnet-group"
  }
}

# Enable DevOps Guru
resource "aws_devopsguru_resource_collection" "rds" {
  type = "AWS_TAGS"
  tags {
        app_boundary_key    = "Name"
        tag_values = ["${var.firm_id_key}-prevail-db"]
      }
}




# Create RDS instance
resource "aws_db_instance" "prevail_db" {
  identifier = "${var.firm_id_key}-prevail-db"
  
  # Engine specifications
  engine         = "postgres"
  engine_version = "16.3"
  
  # Instance specifications
  instance_class = var.instance_type
  
  # Storage specifications
  allocated_storage     = 100
  max_allocated_storage = 1000
  storage_type          = "gp3"
  storage_encrypted     = true
  
  # Database settings
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  # Network settings
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = true
  
  # Backup settings
  backup_retention_period = 30
  # backup_window          = "03:00-04:00"
  
  # Maintenance settings
  # maintenance_window = "Mon:04:00-Mon:05:00"
  
  # Additional settings
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot     = true
  skip_final_snapshot       = true
  
  tags = {
    Name = "${var.firm_id_key}-prevail-db"
  }

  # Enable Performance Insights
  performance_insights_enabled = true
  performance_insights_retention_period = 7
  
  # Enable Enhanced Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
}

# Create IAM role for Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring_role" {
  name = "${var.firm_id_key}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

