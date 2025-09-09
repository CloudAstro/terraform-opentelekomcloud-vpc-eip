module "eip" {
  source = "../../"

  publicip = {
    name = "publicip-example"
    type = "5_bgp"
  }

  bandwidth = {
    name       = "bandwidth-example"
    size       = 10
    share_type = "PER"
  }
}
