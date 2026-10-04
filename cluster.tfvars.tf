variable "cluster_opts" {
  type = object({
    nameservers = list(string)
    kube_proxy  = bool
    cni         = bool
  })
  default = {
    nameservers = ["8.8.8.8"]
    kube_proxy  = false
    cni         = false
  }
}
variable "pod_cidr" {
  type    = string
  default = "172.20.0.0/16"
}

variable "service_cidr" {
  type    = string
  default = "172.25.0.0/16"
}
variable "kubernetes_version" {
  type    = string
  default = "v1.37.1"
}
variable "cluster_name" {
  type    = string
  default = "talos-test-cluster"
}
variable "cluster_endpoint" {
  type    = string
  default = "talos.cluster.local"
}
variable "controlplanes_ips" {
  type = list(string)
}

variable "workers_ips" {
  type = list(string)
}


