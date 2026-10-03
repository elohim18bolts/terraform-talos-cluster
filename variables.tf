#Documentation: https://github.com/siderolabs/image-factory/blob/74025441874f4af8f9a711c51e1b7746af35cd97/docs/api.md?plain=1#L282
variable "image_extensions" {
  type    = list(string)
  default = ["qemu"]
}

variable "nameservers" {
  type    = list(string)
  default = ["1.1.1.1"]
}

variable "talos_version" {
  type    = string
  default = null
}

variable "architecture" {
  type    = string
  default = "amd64"

}

variable "extra_kernel_args" {
  type    = list(string)
  default = ["console=ttyS0,115200"]
}

variable "secure_boot" {
  type = object({
    includeWellKnownCertificates = bool
    enrollKeys                   = string
  })
  default = null
}


variable "bootloader" {
  type    = string
  default = "sd-boot" # optional, defaults to auto (bootloader chosen by imager), other options: dual-boot, grub
}
