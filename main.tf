terraform {
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "~>0.12"
    }
  }
}

module "version" {
  source = "./version"
}
module "image_factory" {
  source        = "./image_factory"
  talos_version = module.version.latest
  architecture  = "arm64"
}

module "cluster" {
  source            = "./cluster"
  controlplanes_ips = ["192.168.100.12", "192.168.100.13"]
  workers_ips       = ["192.168.100.11"]
  cluster_name      = "my-talos-cluster"
}



