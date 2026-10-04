data "talos_image_factory_versions" "this" {
  filters = {
    stable_versions_only = true
  }
}

data "talos_image_factory_extensions_versions" "this" {
  # get the latest talos version
  talos_version = var.talos_version
  filters = {
    names = var.image_extensions
  }
}

resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        extraKernelArgs = var.extra_kernel_args
        secureBoot      = var.secure_boot
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info.*.name
        }
        embeddedMachineConfiguration = templatefile("${path.module}/embedded_machine_configuration.yaml.tftpl", {
          hostname    = "talos-testing"
          nameservers = var.nameservers
        })
      }
    }
  )
}

data "talos_image_factory_urls" "this" {
  talos_version     = var.talos_version
  schematic_id      = talos_image_factory_schematic.this.id
  architecture      = var.architecture
  platform          = var.platform
  disk_image_format = var.disk_image_format
}

