output "myapp_repository_url" {
  value = aws_ecr_repository.myapp.repository_url
  description = "The URL of the ECR repository for the myapp application"
  
}

output "lb_dns_name" {
  value = aws_lb.my_lb.dns_name
  description = "The DNS name of the load balancer"
}
