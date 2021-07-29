module "aci_bgp_policy" {
  source = "netascode/bgp-policy/aci"

  fabric_bgp_as = 65000
  fabric_bgp_rr = [{
    node_id = 1001
    pod     = 1
  }]
  fabric_bgp_external_rr = [{
    node_id = 1001
    pod     = 1
  }]
}
