Azure Application Gateway Deployment with Terraform

This document summarizes the configuration and deployment of an Azure Application Gateway (v2 SKU) using Terraform. The primary goals of this deployment are to implement SSL Offloading and Path-Based Routing.
1. Architecture Overview

The configuration provisions the following key components:

    SKU: Standard_v2 (2 instances)

    Networking: A Virtual Network (meow-vn) with two dedicated subnets:

        meow-subnet-agw: Dedicated to the Application Gateway.

        meow-subnet-backend: Dedicated to hosting backend server IPs (10.254.1.x).

    Frontend: A Standard SKU Public IP address is used to receive external traffic on HTTPS (Port 443).

    Security: Uses a self-signed PFX certificate for SSL Offloading and enforces modern security standards via an explicit TLS policy.

2. Implemented Features
A. SSL Offloading (HTTPS Termination)

The Application Gateway terminates the HTTPS connection, decrypting the traffic using a provided PFX certificate, and then communicates with the backend servers via unencrypted HTTP (Port 80).

Component
	

Configuration
	

Purpose

frontend_port
	

port = 443
	

Listens for encrypted external traffic.

ssl_certificate
	

Uses filebase64("selfsigned.pfx")
	

Uploads the necessary PFX (certificate + private key).

http_listener
	

protocol = "Https"
	

Binds the certificate to the public listener.

backend_http_settings
	

protocol = "Http"
	

Traffic from the AGW to the backend servers is unencrypted (offloading complete).
B. Path-Based Routing

Traffic is distributed to three distinct backend pools based on the URL path requested:

Target Pool
	

Backend IP Address
	

URL Path Rule

web-pool
	

10.254.1.11
	

/path1/

api-pool
	

10.254.1.12
	

/path2/

default-pool
	

10.254.1.10
	

(Default catch-all)
3. Critical Fixes Required During Deployment

The initial code required several crucial fixes to successfully pass Azure's validation checks and deployment requirements:

Issue Encountered
	

Root Cause
	

Terraform Fix Applied

Networking Failure
	

Backend IPs (10.254.1.x) were outside the single defined subnet range (10.254.0.x).
	

Added a dedicated azurerm_subnet.backend_subnet with the 10.254.1.0/24 address space.

Public IP SKU Mismatch
	

AGW V2 requires Standard SKU, but the default Public IP SKU is Basic.
	

Added sku = "Standard" to the azurerm_public_ip resource.

PFX File Encoding Error
	

Using base64encode(file(...)) on a binary PFX file causes a UTF-8 error.
	

Changed the syntax to the binary-safe data = filebase64("selfsigned.pfx").

Deprecated TLS Policy Error (400 Bad Request)
	

Azure blocks deployment if the default, insecure SSL policy (AppGwSslPolicy20150501) is implied.
	

Added the ssl_policy block to enforce a minimum protocol version of TLSv1_2, bypassing the security rejection.
4. Testing

To verify the deployment:

    Get IP: Run az network public-ip show --resource-group meow-rg --name meow-pub-ip --query ipAddress --output tsv.

    Test Access: Open https://[IP_ADDRESS]/ and accept the self-signed certificate warning.

    Test Routing: Verify the routing by checking paths like https://[IP_ADDRESS]/api/status and https://[IP_ADDRESS]/web/index. (Note: These will return 502 Bad Gateway until backend servers are deployed).
