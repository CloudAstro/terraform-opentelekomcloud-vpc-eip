# OpenTelekomCloud Elastic IP Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/CloudAstro/elastic-ip/opentelekomcloud/)

This module is designed to manage Elastic IPs (EIP) within OpenTelekomCloud (OTC). It provides an easy way to allocate, associate, and disassociate Elastic IPs to cloud resources like Virtual Machines, enabling static IP addresses for dynamic workloads.

# Features

- **Elastic IP Management**: Automates the allocation and association of Elastic IPs in OpenTelekomCloud.
- **Dynamic Association**: Supports dynamic allocation and association with OpenTelekomCloud resources like VMs.


# Setup Requirements

To successfully apply the module, make sure to source the required variables either through the `.envrc` file or use `direnv` to automatically load environment variables for configuration. This step is crucial for proper execution of the module.

You can also use AK/SK authentication (`OS_ACCESS_KEY` and `OS_SECRET_KEY`) as an alternative to `OS_PASSWORD` and `OS_USERNAME` for accessing OpenTelekomCloud.

# Example Usage

This example demonstrates how to provision an Elastic IP and associate it with a Virtual Machine in OpenTelekomCloud:
