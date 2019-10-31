provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0fd4fe10cea7264a7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = aws_key_pair.deployer.key_name
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public ip of the machine"
}

output "ssh_command" {
  value       = "ssh ubuntu@${aws_instance.example.public_ip} -i terrakey"
  description = "The command to ssh into the machine"
}
