resource "aws_instance" "filebeat" {
  ami           = data.aws_ami.latest_ubuntu_linux.id
  instance_type = "t2.micro"
  key_name      = "wordpress-key"
  subnet_id = aws_subnet.test_subnet_private_1.id
  vpc_security_group_ids = [aws_security_group.filebeat.id]
  user_data       = data.template_file.user_data_filebeat.rendered
  metadata_options {
    http_endpoint = "enabled"
    instance_metadata_tags = "enabled"
  }
  tags = {
    Name = "filebeat"
  }
}