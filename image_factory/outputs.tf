output "latest" {
  value = element(data.talos_image_factory_versions.this.talos_versions, length(data.talos_image_factory_versions.this.talos_versions) - 1)
}


output "extensions" {
  value = data.talos_image_factory_extensions_versions.this
}


output "talos_image_url" {
  value = data.talos_image_factory_urls.this.urls
}

