Setting Up an AWS EC2 Instance Using Terraform
This guide will help you set up a virtual machine (EC2 instance) on AWS using Terraform. The configurations use variables for flexibility, but you can also hardcode the values if you prefer.

Configuration Overview
Here’s what we’re setting up:
EC2 Instance Type: t3.micro
Operating System: Ubuntu (specified using an AMI ID)
Subnet: Custom (can be configured)
Public IP: Disabled
Root EBS Volume Size: Increased to 12 GB

Step 1: Install the Required Tools
Open your terminal and run:

sudo apt update
sudo apt install awscli -y
aws --version

Install Terraform (Windows)

choco install terraform
Step 2: Set Up AWS CLI
Once AWS CLI is installed, configure it by running:

aws configure
You’ll be prompted to enter the following:

AWS Access Key

AWS Secret Access Key

Log in to the AWS Management Console.

Click your username in the top-right corner and select "My Security Credentials".

Scroll down to Access Keys and click "Create New Access Key".

You can either view the keys on screen or download them as a .csv file.

Step 3: Set Up Your Project Files
Your project should include the following files:

File Name	Description
provider.tf	Sets up the AWS provider and your credentials
main.tf	Defines the EC2 instance configuration
variables.tf	Declares all the input variables used in the main config
terraform.tfvars	Stores the actual values for the variables

Step 4: Run Terraform Commands
Once your files are ready, use the following commands in order:

Initialize the project
terraform init

Check the execution plan
terraform plan

Apply the configuration to launch your EC2 instance
terraform apply -auto-approve

To delete the resources when you're done
terraform destroy -auto-approve

![Screenshot 2025-05-22 232752](https://github.com/user-attachments/assets/e42010c2-b575-445c-acc6-50c8ee8e2d0b)
![Screenshot 2025-05-22 232805](https://github.com/user-attachments/assets/d6092daa-c5aa-42f3-a517-e1c5d3ca78df)


