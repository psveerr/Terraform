resource "aws_subnet" "subnet1" {
  vpc_id                  = var.vpc_id
  cidr_block             = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.public

  tags = var.tags
}