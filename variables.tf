variable "fabric_bgp_as" {
  description = "Fabric BGP AS, Minimum value: 1, Maximum value: 4294967295."
  type        = number

  validation {
    condition     = var.fabric_bgp_as >= 1 && var.fabric_bgp_as <= 4294967295
    error_message = "Minimum value: 1, Maximum value: 4294967295."
  }
}

variable "fabric_bgp_rr" {
  description = "Fabric BGP route reflector nodes, Allowed values `node_id`: 1-4000, Allowed values `pod`: 1-255."
  type = list(object({
    node_id = number
    pod     = number
  }))
  default = []

  validation {
    condition = alltrue([
      for rr in var.fabric_bgp_rr : (rr.node_id >= 1 && rr.node_id <= 4000)
    ])
    error_message = "Minimum value: 1, Maximum value: 4000."
  }

  validation {
    condition = alltrue([
      for rr in var.fabric_bgp_rr : (rr.pod >= 1 && rr.pod <= 255)
    ])
    error_message = "Minimum value: 1, Maximum value: 255."
  }
}

variable "fabric_bgp_external_rr" {
  description = "Fabric BGP external route reflector nodes, Allowed values `node_id`: 1-4000, Allowed values `pod`: 1-255."
  type = list(object({
    node_id = number
    pod     = number
  }))
  default = []

  validation {
    condition = alltrue([
      for rr in var.fabric_bgp_external_rr : (rr.node_id >= 1 && rr.node_id <= 4000)
    ])
    error_message = "Minimum value: 1, Maximum value: 4000."
  }

  validation {
    condition = alltrue([
      for rr in var.fabric_bgp_external_rr : (rr.pod >= 1 && rr.pod <= 255)
    ])
    error_message = "Minimum value: 1, Maximum value: 255."
  }
}
