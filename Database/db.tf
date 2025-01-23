data "aws_secretsmanager_secret" "db_secret" {
  name = "db_password"
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db_subnet_group"
  subnet_ids = [
    aws_subnet.subnet1-public.id,
    aws_subnet.subnet2-public.id,
    aws_subnet.subnet3-public.id
  ]
  depends_on = [aws_route_table_association.terraform-public]
  tags = {
    Name = "DB Subnet Group"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier           = "dbinstance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.39"
  instance_class       = "db.t3.medium"
  db_name              = "devdb"
  username             = "adminuser"
  password             = data.aws_secretsmanager_secret_version.db_secret_version.secret_string
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id

}