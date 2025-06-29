module "network" {
  source = "cktf/network/google"

  name = "mynet"

  subnets = {
    masters = {
      name   = "masters"
      cidr   = "192.168.0.0/24"
      region = "us-central1"
    }
    workers = {
      name   = "workers"
      cidr   = "192.168.1.0/24"
      region = "us-east1"
    }
  }

  firewalls = {
    manager = {
      name      = "manager-firewall"
      direction = "INGRESS"
      sources   = ["tag:mytag", "range:192.168.0.0/24", "service_account:my_sa"]
      targets   = ["tag:mytag", "range:192.168.0.0/24", "service_account:my_sa"]
      allow = {
        "http" = {
          protocol = "tcp"
          ports    = ["80", "443"]
        }
        "docker" = {
          protocol = "tcp"
          ports    = ["2375", "2376"]
        }
      }
      deny = {
        "ssh" = {
          protocol = "tcp"
          ports    = ["22"]
        }
      }
    }
  }
}
