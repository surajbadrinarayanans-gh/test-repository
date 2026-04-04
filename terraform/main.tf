resource "aws_instance" "app_server" {
  ami           = "ami-045443a70fafb8bbc"
  instance_type = "t3.micro"

  # Reference the IAM profile you created earlier
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Add the key pair name here
  key_name = "txn-key" 

  tags = {
    Name = "test-server"
  }
}