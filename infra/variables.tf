variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
  
}

variable "VPC_CIDR" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "PUBLIC_SUBNET_CIDR1" {
  description = "The CIDR block for the public subnet1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "PUBLIC_SUBNET_CIDR2" {
  description = "The CIDR block for the public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "PUBLIC_SUBNET_CIDR3" {
  description = "The CIDR block for the public subnet 3"
  type        = string
  default     = "10.0.3.0/24"
}

variable "PRIVATE_SUBNET_CIDR" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "ECR_REPOSITORY_NAME" {
  description = "The name of the ECR repository"
  type        = string
  default     = "myapp"
}
variable "ECS_CLUSTER_NAME" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "my-ecs-cluster"
}
variable "ECS_TASK_FAMILY" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "my-task-family"
}
variable "CONTAINER_NAME" {
  description = "The name of the container in the ECS task definition"
  type        = string
  default     = "my-container"
}

variable "ECS_SERVICE_NAME" {
  description = "The name of the ECS service"
  type        = string
  default     = "my-ecs-service"
}