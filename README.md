
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
- Install nginx.
    ```
    $ sudo apt update
    $ sudo apt install nginx -y
    ```
- Use the following command to install pip package manager.
    ```
    $ sudo apt install python3-pip
    ```
- Install Flask framework and boto3 library.
    ```
    $ pip install Flask boto3
    ```
- All the requirements are downloaded so now let's setup our Python file.
- Create a directory called `flaskapp` in the home directory of Ubuntu user and save the file `webtier-app.py` in this directory.




**App Tier:**

- Create an EC2 instance from this [public AMI](https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#ImageDetails:imageId=ami-01e547694fca32b28).
- Login as Ubuntu user.
- Use the following command to install pip and boto3 library.
    ```
    $ sudo apt update
    $ sudo apt install python3-pip
    $ pip install boto3
    ```
- Go to Home directory. You will find a python file, a sample image.
- Save the file `apptier-app.py`.
- Save the file `pythonbackend.service` in `/lib/systemd/system` directory.
- We need to Start this system service and Enable it.
    ```
    $ sudo system daemon-reload
    $ sudo systemctl start pythonbackend.service
    $ sudo systemctl enable pythonbackend.service
    ```
- Check the status of service by following command.
    ```
    $ sudo systemctl status pythonbackend.service
    ```



