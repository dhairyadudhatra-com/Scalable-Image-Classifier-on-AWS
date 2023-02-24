from flask import Flask, request
import boto3
import base64
import json
import time
app = Flask(__name__)

sqs = boto3.client('sqs',region_name='us-east-1')

input_queue_url = sqs.get_queue_url(QueueName="web-app-image-transport")["QueueUrl"]
output_queue_url = sqs.get_queue_url(QueueName="app-web-result-queue")["QueueUrl"]

@app.route('/', methods=["POST"])
def process_file():

    img_cont = request.files["myfile"]
    imagename = img_cont.filename
    imagedata = img_cont.read()
    print("\n"+ imagename + " Received")
    

    if img_cont is None:
        return "No file in the request"
    
    image_data = base64.b64encode(imagedata).decode('utf-8')
    message_body = {'image_data': image_data, 'filename': imagename}
    message_json = json.dumps(message_body)

    sqs.send_message(QueueUrl=input_queue_url, MessageBody=message_json)
    #print(imagename+ " uploaded in the queue\n")
    time.sleep(2)
    result = get_result(imagename)
    return result,200 #result, 200

output_dict = {}
def get_result(imagename):
    if imagename in output_dict:
        return output_dict[imagename]
    else:
        while True:
            response = sqs.receive_message(QueueUrl=output_queue_url, MaxNumberOfMessages=1, WaitTimeSeconds=5)
            if 'Messages' in response:
                message = response['Messages'][0]['Body']
                dict1 = json.loads(message)
                print(dict1)
                output_dict[list(dict1.keys())[0]] = list(dict1.values())[0]
                sqs.delete_message(QueueUrl=output_queue_url,ReceiptHandle=response['Messages'][0]['ReceiptHandle'])
                
            if imagename in output_dict:
                return output_dict[imagename]
                                

if __name__ == '__main__' :
    app.run()