provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
}

resource "aws_security_group" "citus_sec_group" {
  name = "terraform-example-instance"
}

resource "aws_security_group_rule" "rule_ingress_ssh" {
  security_group_id = aws_security_group.citus_sec_group.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rule_egress_all" {
  security_group_id = aws_security_group.citus_sec_group.id
  type = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rule_ingress_self" {
  security_group_id = aws_security_group.citus_sec_group.id
  type = "ingress"
  from_port = 9700
  to_port = 9700
  protocol = "tcp"
  self = "true"
}

resource "aws_instance" "coordinator" {
  ami           = "ami-0fd4fe10cea7264a7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.citus_sec_group.id]
  key_name = aws_key_pair.deployer.key_name
}

resource "aws_instance" "worker_1" {
  ami           = "ami-0fd4fe10cea7264a7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.citus_sec_group.id]
  key_name = aws_key_pair.deployer.key_name
}

output "coordinator_private_ip" {
  value       = aws_instance.coordinator.private_ip
  description = "Private ip of the coordinator"
}

output "coordinator_public_ip" {
  value       = aws_instance.coordinator.public_ip
  description = "Public ip of the coordinator"
}

output "coordinator_ssh_command" {
  value       = "ssh ubuntu@${aws_instance.coordinator.public_ip} -i terrakey"
  description = "Command to ssh into the coordinator"
}

output "worker_1_private_ip" {
  value       = aws_instance.worker_1.private_ip
  description = "Private ip of worker_1"
}

output "worker_1_public_ip" {
  value       = aws_instance.worker_1.public_ip
  description = "Public ip of worker_1"
}

output "worker_1_ssh_command" {
  value       = "ssh ubuntu@${aws_instance.worker_1.public_ip} -i terrakey"
  description = "Command to ssh into worker_1"
}
