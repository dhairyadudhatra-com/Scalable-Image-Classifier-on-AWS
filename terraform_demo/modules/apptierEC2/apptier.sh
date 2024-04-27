#!/bin/bash
sudo apt update
cd /home/ubuntu
sudo apt install python3-pip -y
sudo pip3 install boto3
wget https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/requirements.txt https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/apptier-app.py https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/image_classification.py https://github.com/dhairyadudhatra-com/Scalable-Image-Classifier-on-AWS/raw/main/application/imagenet-labels.json
pip3 install -r requirements.txt --no-cache-dir
sudo chmod +x apptier-app.py
sudo python3 apptier-app.py &