# Web Security Group (for public-facing instances)
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Allow inbound HTTP/HTTPS from anywhere, outbound to all"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "web-sg" })
}

# App Security Group (for backend/application instances)
resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "Allow inbound from Web SG, outbound to all"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App traffic from Web SG"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "app-sg" })
}

# DB Security Group (for database instances)
resource "aws_security_group" "db" {
  name        = "db-sg"
  description = "Allow inbound from App SG, outbound to all"
  vpc_id      = var.vpc_id

  ingress {
    description     = "DB traffic from App SG"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "db-sg" })
}
