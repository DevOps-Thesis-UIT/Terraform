terraform {
  backend "s3" {
    bucket = "tuong-backend-bucket"   
    key    = "prod/app/terraform.tfstate"
    region = "us-east-1"                
    encrypt = true                      
    dynamodb_table = "terraform-lock-table" 
  }
}
