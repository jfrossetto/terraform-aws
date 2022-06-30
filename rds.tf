module "dbdev" {
  source        = "app.terraform.io/jfrossetto/rds/aws"
  version       = "1.0.5"
  db_name = "dbMysqlDev"
  db_pass = "password"
  db_user = "admin"
  instance_class = "db.t3.micro"
  instance_name = "dev"
  security_rds = aws_security_group.allow_rds.id  
}
