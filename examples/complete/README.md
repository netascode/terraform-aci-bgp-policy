<!-- BEGIN_TF_DOCS -->
# BGP Policy Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

```hcl
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

```
<!-- END_TF_DOCS -->