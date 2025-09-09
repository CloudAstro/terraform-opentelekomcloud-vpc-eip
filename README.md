<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
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

```hcl
module "vpc" {
  source = "CloudAstro/vpc/opentelekomcloud"
  name   = "vpc-example"
  cidr   = "10.10.0.0/24"
}

module "subnet" {
  source     = "CloudAstro/vpc-subnet/opentelekomcloud"
  name       = "snet-example"
  cidr       = "10.10.0.0/26"
  gateway_ip = "10.10.0.1"
  vpc_id     = module.vpc.vpc_v1.id
}

module "elb" {
  source        = "CloudAstro/elastic-loadbalancer/opentelekomcloud"
  vip_subnet_id = module.subnet.vpc_subnet.subnet_id
}

module "eip" {
  source      = "../../"
  unbind_port = true

  publicip = {
    type = "5_bgp"
    name = "publicip-example"
  }

  bandwidth = {
    name        = "bandwidth-example"
    size        = 10
    share_type  = "PER"
    charge_mode = "traffic"
  }

  tags = {
    foo = "bar"
  }
}
```
<!-- markdownlint-disable MD033 -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_opentelekomcloud"></a> [opentelekomcloud](#requirement\_opentelekomcloud) | >= 1.36.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_opentelekomcloud"></a> [opentelekomcloud](#provider\_opentelekomcloud) | >= 1.36.35 |

## Resources

| Name | Type |
|------|------|
| [opentelekomcloud_networking_floatingip_associate_v2.vip_eip_associate_1](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/networking_floatingip_associate_v2) | resource |
| [opentelekomcloud_vpc_eip_v1.vpc_eip](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/vpc_eip_v1) | resource |

<!-- markdownlint-disable MD013 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_publicip"></a> [publicip](#input\_publicip) | * `publicip` - (Required) The elastic IP address object.<br/>The `publicip` block supports:<br/>  * `type` - (Required) The value must be a type supported by [the system](https://docs.otc.t-systems.com/api/eip/eip_api_0001.html#eip_api_0001__en-us_topic_0201534274_table4491214).<br/>    The value can be `5_bgp`, `5_mailbgp` and `5_gray`. Changing this creates a new eip.<br/>  * `ip_address` - (Optional) The value must be a valid IP address in the available<br/>    IP address segment. Changing this creates a new eip.<br/>  * `port_id` - (Optional) The port id which this eip will associate with. If the value<br/>    is `""` or this not specified, the eip will be in unbind state.<br/>  * `name` - (Required) The ip name, which is a string of 1 to 64 characters.<br/><br/>Example input:<pre>publicip = {<br/>  ip_address = "10.0.0.1"<br/>  name = "my_eip"<br/>  type = "5_bgp"<br/>}</pre> | <pre>object({<br/>    type       = string<br/>    ip_address = optional(string)<br/>    port_id    = optional(string)<br/>    name       = string<br/>  })</pre> | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | * `bandwidth` - (Required) The bandwidth object.<br/>The `bandwidth` block supports:<br/>  * `name` - (Required) The bandwidth name, which is a string of 1 to 64 characters<br/>    that contain letters, digits, underscores (\_), and hyphens (-).<br/>  * `size` - (Required) The bandwidth size. The value ranges from 1 to 300 Mbit/s.<br/>  * `share_type` - (Required) Whether the bandwidth is shared or exclusive. Changing<br/>    this creates a new eip.<br/>  * `charge_mode` - (Optional) This is a reserved field. If the system supports charging<br/>    by traffic and this field is specified, then you are charged by traffic for elastic<br/>    IP addresses. Changing this creates a new eip.<br/>  * `unbind_port` - (Optional) The value `true` indicates that port will be unassigned from EIP.<br/>    This parameter work only with already allocated resource.<br/><br/>Example input:<pre>bandwidth = {<br/>  name        = "test"<br/>  size        = 8<br/>  share_type  = "PER"<br/>  charge_mode = "traffic"<br/>}</pre> | <pre>object({<br/>    name        = string<br/>    size        = number<br/>    share_type  = string<br/>    charge_mode = optional(string)<br/>    tags        = optional(map(any))<br/>    unbind_port = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_floatingip_associate"></a> [floatingip\_associate](#input\_floatingip\_associate) | The following argument is supported:<br/>* `port_id` - (Required) ID of an existing port with at least one IP address to<br/>  associate with this floating IP.<br/><br/>Example input:<pre>floatingip_associate = {<br/>  port_id = opentelekomcloud_compute_instance_v2.this.network.0.port<br/>}</pre> | <pre>object({<br/>    port_id = string<br/>  })</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | * `region` - (Optional) The region in which to obtain the V1 Networking client.<br/>  If omitted, the `region` argument of the provider is used. Changing this<br/>  creates a new service.<br/><br/>Example input:<pre>region = "eu-de"</pre> | `string` | `"eu-de"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | * `tags` - (Optional) Tags key/value pairs to associate with the eip.<br/><br/>Example input:<pre>tags = {<br/>  foo = "bar"<br/>  key = "value"<br/>}</pre> | `map(string)` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | * `timeouts` - (Optional) A timeouts block. This allows you to specify timeouts for create and delete operations.<br/>  * `create` - (Optional) The time to wait for the VPC to be created.<br/>  * `delete` - (Optional) The time to wait for the VPC to be deleted.<br/><br/>Example input:<pre>timeouts = {<br/>  create = "1m"<br/>  delete = "1m"<br/>}</pre> | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_unbind_port"></a> [unbind\_port](#input\_unbind\_port) | * `unbind_port` - (Optional) The value `true` indicates that port will be unassigned from EIP.<br/>  This parameter work only with already allocated resource.<br/><br/>Example input:<pre>unbind_port = true</pre> | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_eip"></a> [vpc\_eip](#output\_vpc\_eip) | The following attributes are exported:<br/>* `id` - The VPC EIP id.<br/>* `region` - See Argument Reference above.<br/>* `publicip/type` - See Argument Reference above.<br/>* `publicip/ip_address` - See Argument Reference above.<br/>* `publicip/port_id` - See Argument Reference above.<br/>* `publicip/name` - See Argument Reference above.<br/>* `bandwidth/name` - See Argument Reference above.<br/>* `bandwidth/size` - See Argument Reference above.<br/>* `bandwidth/share_type` - See Argument Reference above.<br/>* `bandwidth/charge_mode` - See Argument Reference above.<br/>* `tags` - See Argument Reference above.<br/><br/>Example output:<pre>output "publicip-name" {<br/>  value = module.module_name.vpc_eip.publicip[0].name<br/>}</pre> |

## Modules

No modules.

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
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->