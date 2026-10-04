# Talos Terraform Deployment

Will deploy a talos cluster on virtual environments or bare metal. See which variables values can be specify on each module.

**Modules**
- version => Retrieve the latest talos version from siderolabs.
- image_factory => Prepare the talos image and bake in configuration. Output the talos image urls for download.
- cluster => Manages and create clusters of any number of workers and controlplanes.

## Deployment Steps

The cluster mudule doesn't rely on the `image_factory` or `version` modules. The job of the cluster module is `configure`, `apply` and `bootstrap` and already booted up host. So to properly create a cluster using this configuration files is to have the `image_factory` module output the image donwload url, use `curl` or `wget` to download the image and boot the hosts with that image, then use the `cluster` module to bootstrap the cluster.
```bash
terraform apply -target='module.image_factory'
curl -L -O $(terraform output -raw iso_url)
```
The command above will generate the iso url and download the iso image, then you deploy the image on the hosts, change the controlplanes and workers ip to the respective hosts and then `terraform apply`.

For Proxmox you can have the `qcow2` image url by doing `terraform output -raw disk_url`. You then import it into proxmox and create a template and spin the hosts from there or just import the disk into each host(however you'd like), then put the ip of each host in the required vars and `terraform apply`.

## Machine Embedded Configurations

You have the option to embed configs into the `disk` or `iso`  images before installing talos, you can add or modify the `dns server`, or any of the talos machine configurations. If you'd like to do that modify the file located at `image_factory/embedded_machine_configuration.yaml.tftpl` this modifycation will be baked into the image when you download them.
    



