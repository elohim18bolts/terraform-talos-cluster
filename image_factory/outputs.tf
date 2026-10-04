
output "extensions" {
  value = data.talos_image_factory_extensions_versions.this
}


output "talos_image_urls" {
  value = data.talos_image_factory_urls.this.urls
}


output "talos_image_iso" {
  value = data.talos_image_factory_urls.this.urls.iso
}


output "talos_image_disk" {
  value = data.talos_image_factory_urls.this.urls.disk_image
}
