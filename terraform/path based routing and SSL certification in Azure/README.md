Azure Application Gateway Deployment Summary

This document summarizes the configuration and deployment of an Azure Application Gateway (v2 SKU) using Terraform. The primary goals of this deployment were to successfully implement SSL Offloading (HTTPS termination) and Path-Based Routing for traffic distribution.
1. Architecture Overview

The configuration provisions a Standard_v2 SKU Application Gateway with 2 instances. This gateway relies on a robust networking foundation built in the meow-rg Resource Group:

    Virtual Network (meow-vn): Uses the address space 10.254.0.0/16.

    Dedicated Subnets: Two separate subnets were provisioned for security and best practice:

        meow-subnet-agw (10.254.0.0/24): Dedicated solely to the Application Gateway.

        meow-subnet-backend (10.254.1.0/24): Dedicated to hosting the backend server IPs (10.254.1.x).

    Frontend IP: A Standard SKU Public IP is used to receive external traffic on HTTPS (Port 443).

    Security: The setup uses a self-signed PFX certificate for SSL Offloading and enforces modern security standards via an explicit TLS policy.

2. Implemented Features
A. SSL Offloading (HTTPS Termination)

SSL Offloading is configured to terminate the encrypted connection at the Application Gateway, relieving the backend servers of the decryption load.

    The frontend_port is set to port 443 to listen for encrypted external traffic.

    The ssl_certificate block uses the filebase64("selfsigned.pfx") function to upload the PFX file containing the certificate and private key.

    The http_listener uses protocol = "Https" to bind the certificate to the public listener.

    The backend_http_settings uses protocol = "Http" to ensure traffic from the AGW to the backend servers is sent unencrypted, completing the offloading process.

B. Path-Based Routing

Traffic is intelligently distributed to three distinct backend pools based on the URL path requested:

    /web/* traffic is directed to the web-pool (Backend IP: 10.254.1.11).

    /api/* traffic is directed to the api-pool (Backend IP: 10.254.1.12).

    Any other path (the catch-all) is directed to the default-pool (Backend IP: 10.254.1.10).

3. Critical Fixes Required During Deployment

Several non-obvious fixes were necessary to overcome Azure validation errors:

    Networking Failure: The initial single subnet caused a failure because backend IPs were outside its range. The fix was adding a dedicated azurerm_subnet.backend_subnet (10.254.1.0/24).

    Public IP SKU Mismatch: The Application Gateway V2 SKU requires a Standard SKU Public IP. This was fixed by adding sku = "Standard" to the azurerm_public_ip resource.

    PFX File Encoding Error: Terraform requires binary files like PFX to be read with the filebase64() function, not file(). This corrected the data format sent to Azure.

    Deprecated TLS Policy Error (400 Bad Request): To resolve Azure's rejection of the default security policy, an explicit ssl_policy block was added to enforce a minimum protocol version of TLSv1_2, bypassing the security rejection.

4. Testing

To verify the deployment:

    Get Public IP: Run az network public-ip show --resource-group meow-rg --name meow-pub-ip --query ipAddress --output tsv.

    Test Access: Open https://[IP_ADDRESS]/ in a browser and accept the self-signed certificate warning.

    Test Routing: Verify the path routing by accessing specific URLs like https://[IP_ADDRESS]/api/status (should hit the api-pool) and https://[IP_ADDRESS]/web/dashboard (should hit the web-pool).
