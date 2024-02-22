resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.vpc-dtu.id

  # Regla de entrada para permitir el acceso al puerto 8080 desde cualquier dirección IP
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Regla de salida predeterminada
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instancia-dtu" {
  ami                         = "ami-0440d3b780d96b29d"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sub-exxt.id # subred
  key_name                    = "llavesdtu"           # Especifica el nombre de tu par de claves SSH
  associate_public_ip_address = true
  security_groups = ["${aws_security_group.instance_sg.id}"]

  user_data = <<-EOF
  
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo ufw allow 8080
    sudo systemctl start apache2
    EOF

  tags = {
    Name = "Instancia Terraform"
  }
}
resource "aws_key_pair" "llavesdtu" {
  key_name   = "llavesdtu"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 wdtorres@yahoo.com"
}