output "vpc_eip" {
  value       = opentelekomcloud_vpc_eip_v1.vpc_eip
  description = <<DESCRIPTION
The following attributes are exported:
* `id` - The VPC EIP id.
* `region` - See Argument Reference above.
* `publicip/type` - See Argument Reference above.
* `publicip/ip_address` - See Argument Reference above.
* `publicip/port_id` - See Argument Reference above.
* `publicip/name` - See Argument Reference above.
* `bandwidth/name` - See Argument Reference above.
* `bandwidth/size` - See Argument Reference above.
* `bandwidth/share_type` - See Argument Reference above.
* `bandwidth/charge_mode` - See Argument Reference above.
* `tags` - See Argument Reference above.

Example output:
```
output "publicip-name" {
  value = module.module_name.vpc_eip.publicip[0].name
}
```
DESCRIPTION
}
