  #!/bin/bash
  echo "Segundo texto de ejemplo" > ~/mensaje2.txt
  yum update -y
  yum install httpd -y
  systemctl enable httpd
  systemctl start httpd