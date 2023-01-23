import boto3

def lambda_handler(event, context):
    client = boto3.client('ec2')
    resource_id = event['invokingEvent']['configurationItem']['resourceId']
    volume_type = event['invokingEvent']['configurationItem']['configuration']['volumeType']

    if volume_type == 'gp2':
        client.modify_volume(VolumeId=resource_id, VolumeType='gp3')
