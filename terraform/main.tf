resource "aws_instance" "app_server" {
  ami           = "ami-045443a70fafb8bbc"
  instance_type = "t3.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "test-server"
  }
}