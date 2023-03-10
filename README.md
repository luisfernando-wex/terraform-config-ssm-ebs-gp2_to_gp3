# Lambda function and Terraform template for GP2 to GP3 EBS conversion

This repository contains a Terraform template and a Lambda function to convert GP2 EBS volumes to GP3. The solution is built on the AWS Config service and uses a Lambda function to automatically convert GP2 EBS volumes to GP3 when they are detected as non-compliant.

#  Terraform template

The Terraform template creates the following resources:

1. An IAM role for the Lambda function

2. An IAM policy that grants the Lambda function permissions to modify and describe EBS volumes

3. A Lambda function that converts GP2 EBS volumes to GP3

4. A Config rule that checks for GP2 EBS volumes

5. A Config Config rule that associates the Lambda function with the Config rule

6. An SSM Compliance item that defines the compliance standard for EBS volume type 

#  Lambda function
The Lambda function is written in Python and uses the boto3 library to interact with the EC2 service. It takes the resource ID and volume type of an EBS volume as input, and modifies the volume to GP3 if it is of type GP2.


# How to use
1. Clone this repository

2. Install Terraform on your local machine

   - Use `terraform init` command to download the AWS provider

   - Use `terraform plan` command to check the execution plan

   - Use `terraform apply` command to create the resources

   - Use `terraform destroy` command to delete the resources

3. Zip the lambda function and upload it to your S3 bucket

4. Update the lambda function source code in the terraform template with the S3 url of the zip file
