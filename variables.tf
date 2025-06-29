variable "project" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Project"
}

variable "name" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Name"
}

variable "description" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Description"
}

variable "routing_mode" {
  type        = string
  nullable    = false
  sensitive   = false
  description = "Network Routing Model"
  validation {
    condition     = contains(["GLOBAL", "REGIONAL"], var.routing_mode)
    error_message = "Allowed values for routing_mode are 'GLOBAL' or 'REGIONAL'"
  }
}

variable "delete_default_routes" {
  type        = bool
  default     = false
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation"
}

variable "mtu" {
  type        = number
  default     = 1460
  description = "Maximum Transmission Unit in bytes"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "The labels to attach to resources created by this module"
}

variable "subnets" {
  type = map(object({
    cidr                     = string
    region                   = string
    private_ip_google_access = optional(bool, true)
    secondary_ip_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })), [])
    flow_logs          = optional(bool, false)
    flow_logs_interval = optional(string, "INTERVAL_5_SEC")
    flow_logs_sampling = optional(number, 0.5)
    flow_logs_metadata = optional(string, "INCLUDE_ALL_METADATA")
  }))
  default     = {}
  description = "The list of subnets being created"
}

variable "routes" {
  type = map(object({
    destination       = string
    priority          = optional(number, 1000)
    tags              = optional(list(string), [])
    next_hop_gateway  = optional(string)
    next_hop_ip       = optional(string)
    next_hop_instance = optional(string)
  }))
  default     = {}
  description = "List of routes being created in this VPC"
}

variable "firewalls" {
  type = map(object({
    name                    = optional(string)
    description             = optional(string)
    priority                = optional(number, 1000)
    source_ranges           = optional(list(string))
    source_tags             = optional(list(string))
    target_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_service_accounts = optional(list(string))
    allowed_rules = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    denied_rules = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
  }))
  default     = {}
  description = "List of firewall rules"
}
