data "talos_machine_configuration" "controlplane" {
  for_each           = toset(var.controlplanes_ips)
  cluster_name       = var.cluster_name
  machine_type       = "controlplane"
  cluster_endpoint   = "https://${each.key}:6443"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
}

data "talos_machine_configuration" "worker" {
  for_each           = toset(var.workers_ips)
  cluster_name       = var.cluster_name
  machine_type       = "worker"
  cluster_endpoint   = "https://${each.key}:6443"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "controlplane" {
  for_each                    = toset(var.controlplanes_ips)
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane[each.key].machine_configuration
  node                        = each.key
  config_patches = concat([
    templatefile("${path.module}/patches/cluster_cidr.yaml.tftpl", {
      pod_cidr     = var.pod_cidr
      service_cidr = var.service_cidr
    }),
    templatefile("${path.module}/patches/dns.yaml.tftpl", {
      nameservers = var.cluster_opts.nameservers
    }),
    templatefile("${path.module}/patches/kube_proxy.yaml.tftpl", {
      kube_proxy = var.cluster_opts.kube_proxy
    }),
    templatefile("${path.module}/patches/admission_control.yaml.tftpl", {}),
    templatefile("${path.module}/patches/controlplane_scheduling.yaml.tftpl", {}),
    ], var.cluster_opts.cni ? [] : [templatefile("${path.module}/patches/cni.yaml.tftpl", {
      cni = var.cluster_opts.cni
  })])
}

resource "talos_machine_configuration_apply" "worker" {
  for_each                    = toset(var.workers_ips)
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker[each.key].machine_configuration
  node                        = each.key
  config_patches = [
    templatefile("${path.module}/patches/cluster_cidr.yaml.tftpl", {
      pod_cidr     = var.pod_cidr
      service_cidr = var.service_cidr
    }),
    templatefile("${path.module}/patches/dns.yaml.tftpl", {
      nameservers = var.cluster_opts.nameservers
    }),
  ]
}


