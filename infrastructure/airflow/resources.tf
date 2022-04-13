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

resource "aws_s3_bucket" "this" {
  bucket = var.log_bucket
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
