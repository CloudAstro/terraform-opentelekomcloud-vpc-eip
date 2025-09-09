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
