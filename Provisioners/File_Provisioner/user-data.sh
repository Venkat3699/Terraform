
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
echo "<h1>Welcome to Terraform-Server-1</h1>" | sudo tee /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
