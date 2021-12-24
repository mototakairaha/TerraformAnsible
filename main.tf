provider "aws" {
    region = "ap-northeast-1"
}

module "describe_regions_for_ec2" {
    source = "./iam_role"
    name = "describe-region-for-ec2"
    identifier = "ec2.amazonaws.com"
    policy = data.aws_iam_policy_document.allow_describe_regions.json
}
resource "aws_s3_bucket" "private" {
    bucket = "private-pragmatic-terraform"
    versioning{
        enable = false
    }
    server_side_encryption_configuration{
        rule{
            apply_server_side_encryption_by_default{
                sse_algrithm = "AES256"
            }
        }
    }
}
resource "aws_s3_bucket_public_access_block" "private" {
    bucket = aws_s3_bucket.private.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}
/*
data "aws_iam_policy_document" "allow_describe_regions" {
    statement {
        effect = "Allow"
        actions = ["ec2:DescribeRegions"]
        resource = ["*"]
    }
}
resource "aws_iam_group_policy" "example" {
    name = "example"
    policy = data.aws_iam_policy_document.allow_describe_regions.json
}
data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}
resource "aws_iam_role" "example" {
    name = "example"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
resource "aws_iam_group_policy_attachment" "example" {
    role = aws_iam_role.examle.name
    policy_arn = aws_iam_group_policy.example.arn
}

variable "exampl/*e_instance_type" {
    default = "t2.micro"
}
module "web_server" {
    source = "./http_server"
    instance_type = var.example_instance_type
}
output "public_dns" {
    value = module.web_server.public_dns
}

resource "aws_instance" "example"{
    ami = "ami-0218d08a1f9dac831"
    instance_type = var.example_instance_type
    vpc_security_group_ids = [aws_security_group.example_ec2.id]
    tags = {
        Name = "example"
    }
    user_data = file("./user_data.sh")
}
resource "aws_security_group" "example_ec2" {
    name = "example-ec2"
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "example_instance_id" {
    value = aws_instance.example.id
}
*/