output "latest" {
  value = local.version
}


output "extensions" {
  value = data.talos_image_factory_extensions_versions.this
}


output "talos_image_url" {
  value = data.talos_image_factory_urls.this.urls
}


output "talosconfig" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true
}
