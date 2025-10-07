resource "aws_db_subnet_group" "wordpress_subnet_group" {
  name       = "wordpress-subnet_group"
  subnet_ids = [
  aws_subnet.private_subnet_1.id,
  aws_subnet.private_subnet_2.id,
  aws_subnet.private_subnet_3.id
]
}

resource "aws_db_instance" "wordpress" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "wordpress"
  username             = "admin"
  password             = "september30" 
  db_subnet_group_name = aws_db_subnet_group.wordpress_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true
  identifier = "wordpress-db"
}