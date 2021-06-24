data "aws_vpc" "main" {
  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name = "tag:Name"
    values = [
      "public-${var.product}-${var.environment}-0",
      "public-${var.product}-${var.environment}-1"
    ]
  }
}

resource "aws_security_group" "lb" {
  name   = "lb-${var.product}-${var.environment}"
  vpc_id = data.aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_security_group" "api" {
  name   = "api-${var.product}-${var.environment}"
  vpc_id = data.aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

resource "aws_lb" "main" {
  name               = "${var.product}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = data.aws_subnet_ids.public.ids

  tags = {
    Name        = "${var.product}-${var.environment}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "api" {
  count                  = length(var.azs)
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = element(var.azs, count.index)
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.api.id}", "${aws_security_group.lb.id}"]
  subnet_id              = sort(data.aws_subnet_ids.public.ids)[count.index]

  tags = {
    Name        = "api-${var.product}-${var.environment}-${count.index}"
    Project     = var.product
    Owner       = "Terraform"
    Environment = var.environment
  }
}
