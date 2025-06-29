# Terraform Google Network

![pipeline](https://github.com/cktf/terraform-google-network/actions/workflows/ci.yml/badge.svg)
![release](https://img.shields.io/github/v/release/cktf/terraform-google-network?display_name=tag)
![license](https://img.shields.io/github/license/cktf/terraform-google-network)

**Network** is a Terraform module useful for creating **Network**, **Subnets**, **Routes**, and **Firewalls** on **Google**

## Installation

Add the required configurations to your terraform config file and install module using command bellow:

```bash
terraform init
```

## Usage

```hcl
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
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

This project is licensed under the [MIT](LICENSE.md).  
Copyright (c) KoLiBer (koliberr136a1@gmail.com)
