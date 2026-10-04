resource "talos_machine_bootstrap" "this" {
  depends_on = [
    talos_machine_configuration_apply.controlplane,
    talos_machine_configuration_apply.worker
  ]
  node                 = var.controlplanes_ips[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}
