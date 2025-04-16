resource "aws_instance" "frontend" {
  ami                    = "ami-084568db4383264d4" 
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub-sub1.id
  security_groups        = [aws_security_group.alb_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              echo "<h1>Hello from Frontend</h1>" > /var/www/html/index.html
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Frontend-EC2"
  }
}
