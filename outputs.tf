output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "key_pair_name" {
  value = aws_key_pair.this.key_name
}

# Output the path to the saved private key
output "private_key_path" {
  value = local_file.private_key.filename
}

output "bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.spring_bucket.id
}