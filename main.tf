resource "aws_instance" "example"{
    ami = "ami-0218d08a1f9dac831"
    instance_type = "t2.micro"
}