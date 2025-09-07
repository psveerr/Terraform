Terraform VMSS Project Documentation
Project Overview

This project demonstrates the deployment of an Azure Virtual Machine Scale Set (VMSS) with auto-scaling using Terraform. The infrastructure is configured following best practices for security, scalability, and cost estimation. Additional tools like TFLint, Infracost, and TFSec are used to ensure code quality, cost visibility, and security compliance.

Features

Creation of a Resource Group, Virtual Network, Subnet, and Network Security Group.

Deployment of a Linux Virtual Machine Scale Set with manual upgrade mode and auto-scaling based on CPU usage.

SSH-based authentication for VMSS to enhance security.
<img width="1801" height="1008" alt="Screenshot from 2025-09-07 22-59-00" src="https://github.com/user-attachments/assets/3055ac3c-2b7c-4ce2-8e04-44ca4eaef6f1" />


Tagging of resources for better management and identification.

Static code analysis, cost estimation, and security checks for Terraform code.

Generation of cost estimation and cost difference reports.

Prerequisites

Azure CLI installed and authenticated.

Terraform installed.

TFLint, Infracost, and TFSec installed.

SSH key pair for Linux VMSS.

Setup and Usage

Clone the repository and configure the Terraform provider for your Azure subscription. Initialize Terraform and review the execution plan before applying. After applying, Terraform will create all resources defined in the configuration.

Resources can be destroyed when no longer needed, ensuring proper cleanup of all created infrastructure.

TFLint – Terraform Linter

TFLint is used to perform code quality checks and enforce best practices. A plugin for AzureRM is used to validate Azure-specific resources. Detailed logging and report generation can provide visibility into potential misconfigurations and issues in Terraform code.
<img width="1858" height="964" alt="Screenshot from 2025-09-07 23-29-19" src="https://github.com/user-attachments/assets/ba5b0681-e7f1-4bc6-a40e-2d4bb97f7ae6" />


Infracost – Cost Estimation

Infracost is used to estimate the cost of Terraform-managed resources. It can generate cost breakdowns for a plan and compare changes between different plans to highlight cost differences. Environment configuration with an API key is required for report generation.
<img width="1466" height="636" alt="Screenshot from 2025-09-07 23-11-31" src="https://github.com/user-attachments/assets/b3327249-35de-4ea5-9a99-8e57a3c9861e" />


TFSec – Security Scanning

TFSec scans Terraform code for security issues and misconfigurations. Default rules cover common security risks, and custom checks can be added to enforce organizational standards. Reports provide insight into potential vulnerabilities in the infrastructure configuration.
<img width="1383" height="845" alt="Screenshot from 2025-09-07 23-13-12" src="https://github.com/user-attachments/assets/4b3e9f17-85fd-4655-bb20-e29f3b86e119" />


SSH Access to VMSS

The VMSS is configured with SSH key authentication for secure access. Public and private keys are used to manage login access for administrators.
