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

variable "routes" {
  type = map(object({
    name        = optional(string)
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

variable "subnets" {
  type = map(object({
    name        = optional(string)
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

variable "firewalls" {
  type = map(object({
    name        = optional(string)
    priority    = optional(number)
    disabled    = optional(bool, false)
    direction   = optional(string)
    description = optional(string)
    sources     = optional(list(string), [])
    targets     = optional(list(string), [])
    allows      = optional(list(string), [])
    denies      = optional(list(string), [])
  }))
  default     = {}
  sensitive   = false
  description = "Network Firewalls"
}
