provider "aws" {
    region = "ap-northeast-1"
}

variable "example_instance_type" {
    default = "t2.micro"
}

resource "aws_instance" "example"{
    ami = "ami-0218d08a1f9dac831"
    instance_type = var.example_instance_type
    vpc_security_group_ids = [aws_security_group.example_ec2.id]
    tags = {
        Name = "example"
    }
    user_data = <<EOF
        #!/bin/bash
        yum install -y httpd
        systemctl start httpd.service
        systemctl enable httpd.service
    EOF
}
resource "aws_security_group" "example_ec2" {
    name = "example-ec2"
    ingress = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "example_instance_id" {
    value = aws_instance.example.id
}