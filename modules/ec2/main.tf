resource "aws_instance" "ecs_baston" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.vpc.public_subnets[0].id
  vpc_security_group_ids = [var.security_group_baston_name]
  key_name               = var.key_name != "" ? var.key_name : null

  tags = {
    Name = "quiz-ec2-baston"
  }
}

resource "aws_eip" "quiz_baston_eip" {
  instance = aws_instance.ecs_baston.id
  domain   = "vpc"
}

# Data source to choose Amazon Linux 2 if no AMI provided
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
