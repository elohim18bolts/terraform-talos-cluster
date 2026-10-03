locals {
  version = var.talos_version == null ? element(data.talos_image_factory_versions.this.talos_versions, length(data.talos_image_factory_versions.this.talos_versions) - 1) : var.talos_version
}
