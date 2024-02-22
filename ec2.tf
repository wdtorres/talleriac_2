resource "aws_instance" "instancia-dtu" {
  ami                         = "ami-0440d3b780d96b29d"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.SUB-EXT.id # subred
  key_name                    = "llavesdtu"           # Especifica el nombre de tu par de claves SSH
  associate_public_ip_address = true

  user_data = <<-EOF
  
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
        EOF

  tags = {
    Name = "Instancia Terraform"
  }
}
resource "aws_key_pair" "llavesdtu" {
  key_name   = "llavesdtu"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 wdtorres@yahoo.com"
}


resource "aws_security_group" "allow_port_8080" {
  name = "allow_port_8080"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}