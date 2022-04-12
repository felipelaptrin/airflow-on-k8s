resource "aws_db_instance" "this" {
  identifier             = "dev-airflow"
  engine                 = "postgres"
  engine_version         = "13.4"
  port                   = 5432
  username               = var.username
  password               = var.password
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  max_allocated_storage  = 0
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.this.id]
}

resource "aws_security_group" "this" {
  name        = "sg_allow_public_access_rds"
  description = "Allows public access to RDS instance"

  ingress {
    description      = "Postgresql"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

