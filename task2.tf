provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAW75QHBZW"
  secret_key = "Tw1bSFijR/EqfbYpC4WVb8**********"
}

resource "aws_key_pair" "key_pair1" {
  key_name   = "key1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "my_SG1" {
  

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  tags = {
    Name = "sg1"
  }
}

resource "aws_instance" "task2" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair1.key_name
  security_groups= ["${aws_security_group.my_SG1.name}"]
  tags= {
    Name = "OS1"
  }
}


resource "aws_ebs_volume" "ebs1" {
 availability_zone = aws_instance.task2.availability_zone
 size = 1
 tags= {
    Name = "My_ebs1"
  }
}

resource "aws_volume_attachment" "ebs" {
 device_name = "/dev/sdh"
 volume_id = aws_ebs_volume.ebs1.id
 instance_id = aws_instance.task2.id 
}