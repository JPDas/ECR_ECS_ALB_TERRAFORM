resource "aws_ecr_repository" "myapp" {
    name                 = var.ECR_REPOSITORY_NAME
    image_tag_mutability = "MUTABLE"
    force_delete         = true
    
    tags = {
        Environment = "Test"
        Project     = "MyApp"
    }  
}