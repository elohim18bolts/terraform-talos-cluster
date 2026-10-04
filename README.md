# Talos Terraform Deployment

Will deploy a talos cluster on virtual environments or bare metal. See which variables values can be specify on each module.

**Modules**
- version => Retrieve the latest talos version from siderolabs.
- image_factory => Prepare the talos image and bake in configuration. Output the talos image urls for download.
- cluster => Manages and create clusters of any number of workers and controlplanes.



