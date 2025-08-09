
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"  
}

variable "ec2_instance_type"{
    description = "The type of EC2 instance to use"
    type        = string
    default     = "t2.large"
}

variable "ami_id"{
    description = "The AMI ID to use for the EC2 instance"
    type        = string
    default     = "ami-020cba7c55df1f615"  # Example AMI ID, replace with a valid one for your region
} 