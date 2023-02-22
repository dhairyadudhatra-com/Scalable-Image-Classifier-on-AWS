import boto3
import base64
import json
import subprocess
import os

sqs = boto3.client('sqs',region_name='us-east-1')
input_queue_url = sqs.get_queue_url(QueueName="web-app-image-transport")["QueueUrl"]

output_queue_url = sqs.get_queue_url(QueueName="app-web-result-queue")["QueueUrl"]

s3 = boto3.client('s3')



while True:
    response = sqs.receive_message(QueueUrl=input_queue_url, MaxNumberOfMessages=1, VisibilityTimeout=50)
    
    if 'Messages' in response:
        message = response['Messages'][0]['Body']
        dict = json.loads(message)

        imagename = dict['filename']
        bnr_image = base64.b64decode(dict['image_data'])

        with open(imagename,"wb") as f:
            f.write(bnr_image)
        
        

        output = subprocess.check_output(['python3', 'image_classification.py', imagename])
        
        with open(imagename, 'rb') as f:
            s3.upload_fileobj(f, 'image-classifier-input-bucket', imagename)

        output_string =  output.decode('utf-8')
        print(output_string)
        output = b"(" + output[0:-1] + b")"
        s3.put_object(Body=output, Bucket='image-classifier-output-bucket', Key=imagename.split('.')[0])

        os.remove(imagename)

        message_body = {imagename: output_string.split(',')[1]}
        message_json = json.dumps(message_body)
        sqs.send_message(QueueUrl=output_queue_url, MessageBody=message_json)

        sqs.delete_message(QueueUrl=input_queue_url,ReceiptHandle=response['Messages'][0]['ReceiptHandle'])
    else:
        print('No messages in queue')
