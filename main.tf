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
  source            = "./image_factory"
  talos_version     = module.version.latest
  architecture      = "arm64"
  disk_image_format = "qcow2"
  embedded_mc       = <<-EOF
    apiVersion: v1alpha1
    kind: HostnameConfig
    hostname: talos-test
    auto: off
    ---
    apiVersion: v1alpha1
    kind: ResolverConfig
    nameservers: 
      - address: "1.1.1.1"
  EOF
}

module "cluster" {
  source            = "./cluster"
  controlplanes_ips = ["192.168.100.12", "192.168.100.13"]
  workers_ips       = ["192.168.100.11"]
  cluster_name      = "my-talos-cluster"

}




