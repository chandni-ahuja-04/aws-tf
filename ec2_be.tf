resource "aws_instance" "backend" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private-sub1.id
  security_groups = [aws_security_group.app_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y nodejs
    echo "const http = require('http');
    http.createServer((req, res) => {
      res.write('Hello World!');
      res.end();
    }).listen(3000);" > app.js
    nohup node app.js &
  EOF

  tags = {
    Name = "Backend Instance"
  }
}
