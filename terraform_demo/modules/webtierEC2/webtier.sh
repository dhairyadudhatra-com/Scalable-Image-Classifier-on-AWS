#!/bin/bash
sudo apt update
mkdir /home/ubuntu/flaskapp
cd /home/ubuntu/flaskapp
sudo apt install nginx python3-pip -y
sudo pip3 install flask boto3
wget https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/webtier-app.py https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/default
sudo chmod +x webtier-app.py
nohup python3 webtier-app.py > /dev/null 2>&1 &
sudo rm /etc/nginx/sites-available/default
sudo mv default /etc/nginx/sites-available/
cd /etc/nginx/sites-enabled/
sudo rm default
sudo ln -s /etc/nginx/sites-available/default .
sudo systemctl restart nginx