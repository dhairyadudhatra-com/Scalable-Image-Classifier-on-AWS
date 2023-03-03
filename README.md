
# Scalable Image Classifier on AWS


We have made a 3 tier web application which takes an image, classifies it, stores it into the S3 bucket and return the result to user.
We have used EC2 instances for hosting Web and App tier. Web tier sends these images to App tier through a SQS queue and we are monitoring this queue using Cloudwatch service. We use these Cloudwatch alarms to give signal to AutoScalling which further decides if there is a need to scale app tier or not.


## Authors
#### Team -  DADCloud
- [@Dhairya Dudhatra](https://github.com/Dhairya-Dudhatra)
- [@Arush Patel](https://github.com/arushPatel10)
- [@Dirgh Patel](https://github.com/DIRGH712)


## How to Setup the environment
To run this project, clone this repo:
    ```
    $ git clone https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS.git
    ```

Now setup these two environments as suggested:


**Web Tier:**

- Create an Ubuntu based EC2 instance in AWS.
- Install the dependencies and libraries by following these commands.
    ```
    $ sudo apt update
    $ sudo apt install nginx -y
    $ sudo apt install python3-pip
    $ pip install Flask boto3
    ```
- Setup the work directory and save these files.
    ```
    $ mkdir flaskapp && cd flaskapp
    $ wget https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/webtier-app.py /
      https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/default
      https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/pythonfrontend.service
    ```
- Move the file `pythonfrontend.service` to the `/lib/systemd/system` and run these commands to create a system service.
    ```
    $ sudo system daemon-reload
    $ sudo systemctl start pythonfrontend.service
    $ sudo systemctl enable pythonfrontend.service
    ```
- Check the status of service by following command.
    ```
    $ sudo systemctl status pythonfrontend.service
    ```
- Replace the old `default` file in `/etc/nginx/sites-available/` with the new `default` file just downloaded.

- Now restart the Nginx service after saving config file.
    ```
    $ sudo systemctl restart nginx
    ```




**App Tier:**

- Create an EC2 instance from this [public AMI](https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#ImageDetails:imageId=ami-01e547694fca32b28).
- Login as Ubuntu user.
- Use the following command to install all the requirements.
    ```
    $ sudo apt update
    $ sudo apt install python3-pip
    $ pip install boto3
    ```
- Change your current directory to home directory of Ubuntu user and download these file.
    ```
    $ wget https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/apptier-app.py /
      https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/pythonbackend.service /
    ```
- Move the file `pythonbackend.service` to the `/lib/systemd/system` and run these commands to create a system service.
    ```
    $ sudo system daemon-reload
    $ sudo systemctl start pythonbackend.service
    $ sudo systemctl enable pythonbackend.service
    ```
- Check the status of service by following command.
    ```
    $ sudo systemctl status pythonbackend.service
    ```



