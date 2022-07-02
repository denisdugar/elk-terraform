data "aws_ami" "latest_ubuntu_linux" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "template_file" "user_data_master" {
  template = "${file("user_data_master.sh")}"
}

data "template_file" "user_data_bastion" {
  template = "${file("user_data_bastion.sh")}"
}

data "template_file" "user_data_nodes" {
  template = "${file("user_data_nodes.sh")}"
}

data "template_file" "user_data_logstash" {
  template = "${file("user_data_logstash.sh")}"
}

data "template_file" "user_data_kibana" {
  template = "${file("user_data_kibana.sh")}"
}

data "template_file" "user_data_filebeat" {
  template = "${file("user_data_filebeat.sh")}"
}
