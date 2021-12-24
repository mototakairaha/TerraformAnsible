provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "example"{
    ami = "ami-0218d08a1f9dac831"
    instance_type = "t2.micro"
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