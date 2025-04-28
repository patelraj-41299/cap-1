resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-launch-"
  image_id      = "ami-0dca0c2a03832e0eb"
  instance_type = "t2.micro"
  key_name      = "key-1"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    sudo yum update -y
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
    sudo yum install -y nodejs
    cd /home/ec2-user/cap-1/backend
    npm install
    nohup node server.js > server.log 2>&1 &
  EOT
  )
}
