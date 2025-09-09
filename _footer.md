## 🌐 Additional Information  

This module provides an easy way to allocate and manage Elastic IPs (EIPs) in OpenTelekomCloud, enabling dynamic workloads to have static public IPs. It supports association with cloud resources like Virtual Machines and offers tagging and timeout features to customize the deployment.

## 📚 Resources

- [Terraform OpenTelekomCloud Elastic IP Resource](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/eip_v1)  
- [OpenTelekomCloud Elastic IP Overview](https://docs.otc.t-systems.com/elastic-ip/index.html)  
- [Terraform OpenTelekomCloud Provider](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs)  

## ⚠️ Notes  

- Elastic IPs (EIPs) are billed based on usage, so be mindful of the number of EIPs in use to optimize costs.
- Ensure proper association of Elastic IPs with your cloud resources to maintain network connectivity.
- Tagging Elastic IPs is recommended for better management and tracking of resources within your environment.

## 🧾 License  

This module is released under the **Apache 2.0 License**. See the [LICENSE](./LICENSE) file for full details.
