variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

variable "key_pair_name" {
  description = "Name of the key pair to create"
  type        = string
  default     = "mykey-pair"
}

variable "desktop_path" {
  description = "Path to the desktop directory"
  type        = string
  default     = "C:/Users/user/Desktop" # Default Windows path, change as needed
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "spring-buck"
}