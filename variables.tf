variable "mtu" {
  type        = number
  default     = null
  sensitive   = false
  description = "Network MTU"
}

variable "name" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Name"
}

variable "profile" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Profile"
}

variable "description" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Description"
}

variable "routing_mode" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Routing Mode"
}

variable "path_selection_mode" {
  type        = string
  default     = null
  sensitive   = false
  description = "Network Path Selection Mode"
}

variable "subnets" {
  type = map(object({
    name        = string
    cidr        = string
    region      = string
    description = optional(string)
    reserved    = optional(string)
    purpose     = optional(string)
    role        = optional(string)

    secondaries = optional(map(object({
      name     = string
      cidr     = string
      reserved = optional(string)
    })), {})
  }))
  default     = {}
  sensitive   = false
  description = "Network Subnets"
}

variable "routes" {
  type = map(object({
    name        = string
    tags        = optional(list(string), [])
    priority    = optional(number)
    description = optional(string)
    destination = string
    next_hop    = string
  }))
  default     = {}
  sensitive   = false
  description = "Network Routes"
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
