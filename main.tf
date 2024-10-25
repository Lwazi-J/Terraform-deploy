terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create the AWS key pair
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the AWS key pair
resource "aws_key_pair" "this" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.this.public_key_openssh
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.desktop_path}/${var.key_pair_name}.pem"
  file_permission = "0400"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "spring_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_ownership_controls" "spring_bucket_ownership" {
  bucket = aws_s3_bucket.spring_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "spring_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.spring_bucket_ownership]

  bucket = aws_s3_bucket.spring_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "spring_bucket_versioning" {
  bucket = aws_s3_bucket.spring_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
