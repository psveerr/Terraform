Azure Application Gateway Deployment (Terraform)

This project provisions an Azure Application Gateway (v2 SKU) using Terraform.
The primary objectives were to implement:

SSL Offloading (HTTPS Termination)

Path-Based Routing for intelligent traffic distribution.

1. Architecture Overview

The deployment provisions a Standard_v2 Application Gateway with 2 instances.
All resources are deployed in the meow-rg resource group.

Networking

Virtual Network: meow-vn with address space 10.254.0.0/16.

Subnets:

meow-subnet-agw (10.254.0.0/24) → dedicated to Application Gateway.

meow-subnet-backend (10.254.1.0/24) → used for backend server IPs (10.254.1.x).

Frontend IP: Standard SKU Public IP (meow-pub-ip) to receive external HTTPS traffic on port 443.

2. Implemented Features
A. SSL Offloading (HTTPS Termination)

Frontend listener configured on port 443.

SSL certificate uploaded using filebase64() to ensure binary-safe encoding.

http_listener bound with protocol = "Https".

backend_http_settings set to HTTP (unencrypted) for internal traffic between AGW and backend.

B. Path-Based Routing

Traffic is routed based on the request path:

/path1/ → web-pool → Backend IP: 10.254.1.11

/path2/ → api-pool → Backend IP: 10.254.1.12

Any other path → default-pool → Backend IP: 10.254.1.10
