
# Scalable Image Classifier on AWS


We have made a 3 tier web application which takes an image, classifies it, stores it into the S3 bucket and return the result to user.
We have used EC2 instances for hosting Web and App tier. Web tier sends these images to App tier through a SQS queue and we are monitoring this queue using Cloudwatch service. We use these Cloudwatch alarms to give signal to AutoScalling which further decides if there is a need to scale app tier or not.


## Architecture
![Arch Image](https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS/raw/main/arch.png)

## How to Run the Project
- To run this project, clone this repo:
    ```
    $ git clone https://github.com/Dhairya-Dudhatra/Scalable-Image-Classifier-on-AWS.git
    ```
- Now run the following command in the `Scalable-Image-Classifier-on-AWS.git/` directory.
    ```
    $ python3 multithread_workload_generator.py --num_request 100 --url 'http:// <webtier-public-ip> /' --image_folder "imagenet-100/"
    ```
    This command will send  100 concurrent requests to the web server.
    

## How to Setup the Environments
Setup these three environments as suggested:


**AWS Resources Setup:**
- Open the CloudFormation console in your AWS environment.
- Create a stack from infra.yaml file.
- It will take around 5-10 minutes for AWS to create all the resources.

## Creators
#### Team -  DADCloud
- [@Dhairya Dudhatra](https://github.com/Dhairya-Dudhatra)

## Blog
- [https://medium.com/@dhairyadudhatra4819/scalable-image-classifier-on-aws-fa44444c4c6c](https://medium.com/@dhairyadudhatra4819/scalable-image-classifier-on-aws-fa44444c4c6c)
