# ADR-001: OpenVPN Network Virtual Appliance (NVA) Azure Deployment

* **Status:** Accepted
* **Date:** 2026-10-20
* **Author:** Infrastructure Architecture

## Context & Scope
We needed a secure, reliable, and isolated Network Virtual Appliance (NVA) running OpenVPN on Microsoft Azure (`austriaeast` region) within the `fulltunvpn` resource group. The architecture must use modular Terraform code (`networking` and `compute` modules) and store the resulting OpenVPN client profile (`client1.ovpn`) alongside the Terraform state in the Azure Storage Account (`stddemofulltunvpn01`).

## Decision
1. **Infrastructure as Code (IaC):** Implemented using Terraform modules (`modules/networking` and `modules/compute`) with a `Standard_B1s` Ubuntu 24.04 LTS virtual machine.
2. **VPN Automation:** Deployed OpenVPN using the automated setup tool, configuring UDP/1194, Cloudflare DNS, and client certificate generation.
3. **Artifact Persistence:** The generated `client.ovpn` (stored as `client1.ovpn`) is transferred locally via SCP and uploaded securely to the `tfstate` storage container using account key authentication.

## Consequences
* **Pros:** Fully repeatable hybrid cloud infrastructure; isolated and secure tunneling; centralized storage of client profiles next to state files.
* **Cons:** Manual or scripted post-provisioning step required to trigger the VPN installation script on the fresh VM instance.
