variable "region" {
  type        = string
  default     = "eu-de"
  description = <<DESCRIPTION
* `region` - (Optional) The region in which to obtain the V1 Networking client.
  If omitted, the `region` argument of the provider is used. Changing this
  creates a new service.

Example input:
```
region = "eu-de"
```
DESCRIPTION
}

variable "publicip" {
  type = object({
    type       = string
    ip_address = optional(string)
    port_id    = optional(string)
    name       = string
  })
  nullable    = false
  description = <<DESCRIPTION
* `publicip` - (Required) The elastic IP address object.
The `publicip` block supports:
  * `type` - (Required) The value must be a type supported by [the system](https://docs.otc.t-systems.com/api/eip/eip_api_0001.html#eip_api_0001__en-us_topic_0201534274_table4491214).
    The value can be `5_bgp`, `5_mailbgp` and `5_gray`. Changing this creates a new eip.
  * `ip_address` - (Optional) The value must be a valid IP address in the available
    IP address segment. Changing this creates a new eip.
  * `port_id` - (Optional) The port id which this eip will associate with. If the value
    is `""` or this not specified, the eip will be in unbind state.
  * `name` - (Required) The ip name, which is a string of 1 to 64 characters.

Example input:
```
publicip = {
  ip_address = "10.0.0.1"
  name = "my_eip"
  type = "5_bgp"
}
```
DESCRIPTION
}

variable "bandwidth" {
  type = object({
    name        = string
    size        = number
    share_type  = string
    charge_mode = optional(string)
    tags        = optional(map(any))
    unbind_port = optional(bool)
  })
  default     = null
  description = <<DESCRIPTION
* `bandwidth` - (Required) The bandwidth object.
The `bandwidth` block supports:
  * `name` - (Required) The bandwidth name, which is a string of 1 to 64 characters
    that contain letters, digits, underscores (_), and hyphens (-).
  * `size` - (Required) The bandwidth size. The value ranges from 1 to 300 Mbit/s.
  * `share_type` - (Required) Whether the bandwidth is shared or exclusive. Changing
    this creates a new eip.
  * `charge_mode` - (Optional) This is a reserved field. If the system supports charging
    by traffic and this field is specified, then you are charged by traffic for elastic
    IP addresses. Changing this creates a new eip.
  * `unbind_port` - (Optional) The value `true` indicates that port will be unassigned from EIP.
    This parameter work only with already allocated resource.

Example input:
```
bandwidth = {
  name        = "test"
  size        = 8
  share_type  = "PER"
  charge_mode = "traffic"
}
```
DESCRIPTION
}

variable "tags" {
  type        = map(string)
  default     = null
  description = <<DESCRIPTION
* `tags` - (Optional) Tags key/value pairs to associate with the eip.

Example input:
```
tags = {
  foo = "bar"
  key = "value"
}
```
DESCRIPTION
}

variable "unbind_port" {
  type        = bool
  default     = null
  description = <<DESCRIPTION
* `unbind_port` - (Optional) The value `true` indicates that port will be unassigned from EIP.
  This parameter work only with already allocated resource.

Example input:
```
unbind_port = true
```
DESCRIPTION
}

variable "floatingip_associate" {
  type = object({
    port_id = string
  })
  default     = null
  description = <<DESCRIPTION
The following argument is supported:
* `port_id` - (Required) ID of an existing port with at least one IP address to
  associate with this floating IP.

Example input:
```
floatingip_associate = {
  port_id = opentelekomcloud_compute_instance_v2.this.network.0.port
}
```
DESCRIPTION
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  default     = null
  description = <<DESCRIPTION
* `timeouts` - (Optional) A timeouts block. This allows you to specify timeouts for create and delete operations.
  * `create` - (Optional) The time to wait for the VPC to be created.
  * `delete` - (Optional) The time to wait for the VPC to be deleted.

Example input:
```
timeouts = {
  create = "1m"
  delete = "1m"
}
```
DESCRIPTION
}
