resource "aws_security_group" "es_sg" {
  name        = "es_sg"
  description = "sg for es ec2"
  vpc_id      = aws_vpc.test_vpc.id
  
  dynamic "ingress" {
    for_each = ["80", "9200", "9300", "9600", "5044"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "es_sg"
  }
}


resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "sg for es ec2"
  vpc_id      = aws_vpc.test_vpc.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_security_group" "kibana_sg" {
  name        = "kibana_sg"
  description = "sg for kibana ec2"
  vpc_id      = aws_vpc.test_vpc.id
  
  dynamic "ingress" {
    for_each = ["22", "80", "5601", "4180"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kibana_sg"
  }
}

resource "aws_security_group" "filebeat" {
  name        = "filebeat"
  description = "sg for filebeat ec2"
  vpc_id      = aws_vpc.test_vpc.id
  
  dynamic "ingress" {
    for_each = ["80", "5044"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "filebeat"
  }
}