output "latest" {
  value = local.version
}


output "extensions" {
  value = data.talos_image_factory_extensions_versions.this
}


output "talos_image_url" {
  value = data.talos_image_factory_urls.this.urls.installer
}
