resource "talos_machine_secrets" "this" {}


data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = concat(var.controlplanes_ips, var.workers_ips)
}



