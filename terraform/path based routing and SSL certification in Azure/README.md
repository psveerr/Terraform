Azure Application Gateway Deployment (Terraform)

This project provisions an Azure Application Gateway (v2 SKU) using Terraform.
The primary objectives were to implement:

SSL Offloading (HTTPS Termination)

Path-Based Routing for intelligent traffic distribution.

<img width="749" height="561" alt="Screenshot from 2025-09-28 15-00-40" src="https://github.com/user-attachments/assets/a1a5f4ff-3879-4861-8bad-33342b388d1e" />



1. Architecture Overview

The deployment provisions a Standard_v2 Application Gateway with 2 instances.
All resources are deployed in the meow-rg resource group.

Networking

Virtual Network: meow-vn with address space 10.254.0.0/16.



Subnets:

meow-subnet-agw (10.254.0.0/24) → dedicated to Application Gateway.

meow-subnet-backend (10.254.1.0/24) → used for backend server IPs (10.254.1.x).

<img width="1920" height="1080" alt="Screenshot from 2025-09-28 11-54-24" src="https://github.com/user-attachments/assets/43e6319a-07d8-4813-9f27-62b20a718efb" />


Frontend IP: Standard SKU Public IP (meow-pub-ip) to receive external HTTPS traffic on port 443.

2. Implemented Features
A. SSL Offloading (HTTPS Termination)

Frontend listener configured on port 443.

SSL certificate uploaded using filebase64() to ensure binary-safe encoding.

http_listener bound with protocol = "Https".

backend_http_settings set to HTTP (unencrypted) for internal traffic between AGW and backend.

<img width="738" height="716" alt="Screenshot from 2025-09-28 15-00-12" src="https://github.com/user-attachments/assets/4823f9fb-4a93-49b3-b387-64ba7982f074" />
<img width="727" height="112" alt="Screenshot from 2025-09-28 15-00-23" src="https://github.com/user-attachments/assets/e1713900-fcf8-4bc3-aecc-017752e256c6" />



B. Path-Based Routing

Traffic is routed based on the request path:

/path1/ → web-pool → Backend IP: 10.254.1.11

/path2/ → api-pool → Backend IP: 10.254.1.12

Any other path → default-pool → Backend IP: 10.254.1.10
