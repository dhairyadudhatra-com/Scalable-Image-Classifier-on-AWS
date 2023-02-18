from flask import Flask, request
import boto3
import base64
import json

app = Flask(__name__)

sqs = boto3.client('sqs',region_name='us-east-1')
input_queue_url = sqs.get_queue_url(QueueName="web-app-image-transport")["QueueUrl"]
output_queue_url = sqs.get_queue_url(QueueName="app-web-result-queue")["QueueUrl"]

@app.route('/', methods=["POST"])
def process_file():

    img_cont = request.files["myfile"].read()
    imagename = request.form['filename']
    print("\n"+ imagename + " Received")
    

    if img_cont is None:
        return "No file in the request"
    
    image_data = base64.b64encode(img_cont).decode('utf-8')
    message_body = {'image_data': image_data, 'filename': imagename}
    message_json = json.dumps(message_body)
    sqs.send_message(QueueUrl=input_queue_url, MessageBody=message_json)
    print(imagename+ " uploaded in the queue\n")

    result = get_result(imagename)
    return result, 200

def get_result(imagename):
    while True:
        response = sqs.receive_message(QueueUrl=output_queue_url, MaxNumberOfMessages=1)
        if 'Messages' in response:
            message = response['Messages'][0]['Body']
            dict = json.loads(message)
            if imagename in dict:
                sqs.delete_message(QueueUrl=output_queue_url,ReceiptHandle=response['Messages'][0]['ReceiptHandle'])
                return dict[imagename]
            else:
                print("not found ... checking more messages")


if __name__ == '__main__' :
    app.run()
