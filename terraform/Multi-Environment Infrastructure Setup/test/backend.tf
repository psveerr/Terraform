terraform {
  backend "s3" {
    bucket         = "cancertumoralive"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-2"
  }
}