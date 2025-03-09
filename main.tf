provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAFAKEACCESSKEYEXAMPLE"  # 🚨 Hardcoded AWS Access Key (Secret)
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"  # 🚨 Hardcoded AWS Secret Key (Secret)
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"  # 🚨 Publicly accessible bucket
}

resource "aws_security_group" "bad_sg" {
  name        = "bad-sg"
  description = "Security group with open ports"
  vpc_id      = "vpc-123456"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 🚨 Allows all traffic from anywhere
  }
}

resource "aws_instance" "insecure_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "my-unsecured-key"

  metadata_options {
    http_tokens = "optional"  # 🚨 Instance metadata service should enforce tokens (SSRF risk)
  }

  user_data = <<EOF
#!/bin/bash
echo "root:toor" | chpasswd  # 🚨 Hardcoded credentials
EOF
}

resource "aws_db_instance" "bad_db" {
  identifier              = "insecure-db"
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  publicly_accessible     = true  # 🚨 Publicly accessible database
  skip_final_snapshot     = true
  username               = "admin"
  password               = "password123"  # 🚨 Weak password stored in Terraform file
}
