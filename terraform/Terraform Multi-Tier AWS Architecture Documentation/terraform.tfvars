aws_region    = "ap-southeast-2"
vpc_cidr      = "173.31.0.0/16"
az_count      = 2
db_pass       = "MeowMeow123"
availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
key_name      = "prod-key"
instance_type = "t2.micro"
ami_id        = "ami-0f5d1713c9af4fe30"
user_data     = ""
tags = {
  Project     = "Task4_veer"
}
