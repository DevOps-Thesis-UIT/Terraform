terraform {
  backend "s3" {
    bucket = "tf-backend-s3-bucket"   
    key    = "prod/app/terraform.tfstate"
    region = "us-east-1"                
    encrypt = true                      
    dynamodb_table = "terraform-lock-table" 
  }
}
