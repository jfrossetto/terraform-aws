module "dbdev" {
  source        = "app.terraform.io/jfrossetto/rds/aws"
  version       = "1.0.0"
  db_name = "dbMysqlDev"
  db_pass = "password"
  db_user = "admin"
  instance_class = "db.t3.micro"
  instance_name = "dev"
}

module "dbmain" {
  source        = "app.terraform.io/jfrossetto/rds/aws"
  version       = "1.0.0"
  db_name = "dbMysqlMain"
  db_pass = "password"
  db_user = "admin"
  instance_class = "db.t3.micro"
  instance_name = "maindb"
}
