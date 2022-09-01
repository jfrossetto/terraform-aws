module "dbdev" {
  source         = "app.terraform.io/jfrossetto/rds/aws"
  version        = "1.0.6"
  db_name        = "dbMysqlDev"
  db_pass        = "password"
  db_user        = "admin"
  instance_class = "db.t3.micro"
  instance_name  = "dev"
  security_rds   = aws_security_group.allow_rds.id
  db_subnet_name = aws_db_subnet_group.db_group.id
}

resource "aws_security_group" "allow_rds" {
  name        = "allow_rds"
  description = "Allow rds inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "RDS from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_rds"
  }
}

resource "aws_db_subnet_group" "db_group" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  tags = {
    Name = "My DB subnet group"
  }
}
