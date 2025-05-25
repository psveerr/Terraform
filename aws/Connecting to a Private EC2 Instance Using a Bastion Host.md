Connecting to a Private EC2 Instance Using a Bastion Host

Objective:
To connect to a private EC2 instance through a public EC2 instance (bastion host) using SSH.

Steps:

Create a VPC with CIDR block 10.0.0.0/16.

Create two subnets:

Public subnet with CIDR 10.0.1.0/24

Private subnet with CIDR 10.0.2.0/24

Create and attach an Internet Gateway to the VPC.

Edit the route table associated with the public subnet. Add a route to 0.0.0.0/0 via the Internet Gateway.

Launch two EC2 instances:

One in the public subnet (this is the bastion host)

One in the private subnet (this is the private instance)

Ensure each instance uses a different key pair:

Public EC2 (bastion) uses bastion-key.pem

Private EC2 uses private-key.pem

Connect to the public EC2 instance from your local machine using:
ssh -i "path/to/bastion-key.pem" ubuntu@<public-ec2-public-ip>

From your local machine, upload the private EC2 key to the bastion EC2 using SCP:
scp -i "path/to/bastion-key.pem" "path/to/private-key.pem" ubuntu@<public-ec2-public-ip>:~

SSH into the public EC2 instance again and set permissions for the uploaded key:
chmod 400 private-key.pem

From inside the public EC2 instance, connect to the private EC2 instance:
ssh -i private-key.pem ubuntu@<private-ec2-private-ip>

At this point, you are connected to the private EC2 instance via the bastion host.




![Screenshot 2025-05-25 233916](https://github.com/user-attachments/assets/552c2af3-3323-43ae-957a-1181258957f9)
![Screenshot 2025-05-25 234607](https://github.com/user-attachments/assets/f6db1539-a845-4797-82d8-a050045b9f6e)
![Screenshot 2025-05-25 234744](https://github.com/user-attachments/assets/7757f3eb-0d99-4365-be3c-5f395d99604e)
![Screenshot 2025-05-25 234938](https://github.com/user-attachments/assets/14cdc2dc-d549-4989-a7cc-af94cf02c5ab)
![Screenshot 2025-05-25 235037](https://github.com/user-attachments/assets/9047cd4f-1c1f-4d8c-ae68-7ea0354e50b6)
![Screenshot 2025-05-25 235530](https://github.com/user-attachments/assets/6ff13ce9-0b88-40c5-bc3a-a61282f5f394)
![Screenshot 2025-05-25 235814](https://github.com/user-attachments/assets/c8e6cb89-6178-451d-814d-a076fa514d42)
![Screenshot 2025-05-26 003003](https://github.com/user-attachments/assets/cca1d66c-1240-4509-a3e5-73539ee43fe4)
![Screenshot 2025-05-26 004245](https://github.com/user-attachments/assets/a7fda73c-1a87-4c8e-bb05-da01ab29073e)

















