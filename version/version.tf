data "talos_image_factory_versions" "this" {
  filters = {
    stable_versions_only = true
  }
}



