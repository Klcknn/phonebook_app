resource "aws_security_group" "alb-sg" {  # First Security Group for ALB
  name = "ALBSecurityGroup"
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = "TF_ALBSecurityGroup"
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "server-sg" {  # Second Security Group for EC2 Web-Server Instance
  name = "WebServerSecurityGroup"
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = "TF_WebServerSecurityGroup"
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    security_groups = [aws_security_group.alb-sg.id]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db-sg" {    # Third Security Group for RDS 
  name = "RDSSecurityGroup"
  vpc_id = data.aws_vpc.selected.id
  tags = {
    "Name" = "TF_RDSSecurityGroup"
  }
  ingress {
    security_groups = [aws_security_group.server-sg.id]
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol = -1
    to_port = 0
  }
}