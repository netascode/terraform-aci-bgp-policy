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
