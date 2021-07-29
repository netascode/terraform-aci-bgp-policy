terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

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

data "aci_rest" "bgpAsP" {
  dn = "uni/fabric/bgpInstP-default/as"

  depends_on = [module.main]
}

resource "test_assertions" "bgpAsP" {
  component = "bgpAsP"

  equal "asn" {
    description = "asn"
    got         = data.aci_rest.bgpAsP.content.asn
    want        = "65000"
  }
}

data "aci_rest" "bgpRRNodePEp" {
  dn = "uni/fabric/bgpInstP-default/rr/node-1001"

  depends_on = [module.main]
}

resource "test_assertions" "bgpRRNodePEp" {
  component = "bgpRRNodePEp"

  equal "id" {
    description = "id"
    got         = data.aci_rest.bgpRRNodePEp.content.id
    want        = "1001"
  }

  equal "podId" {
    description = "podId"
    got         = data.aci_rest.bgpRRNodePEp.content.podId
    want        = "1"
  }
}

data "aci_rest" "bgpRRNodePEp-Ext" {
  dn = "uni/fabric/bgpInstP-default/extrr/node-1001"

  depends_on = [module.main]
}

resource "test_assertions" "bgpRRNodePEp-Ext" {
  component = "bgpRRNodePEp-Ext"

  equal "id" {
    description = "id"
    got         = data.aci_rest.bgpRRNodePEp.content.id
    want        = "1001"
  }

  equal "podId" {
    description = "podId"
    got         = data.aci_rest.bgpRRNodePEp.content.podId
    want        = "1"
  }
}
