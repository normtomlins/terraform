terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.68.132:8006/api2/json"
  #pm_api_token_id = "root@pam!TerraForm"
  #pm_api_token_secret = "a1833fe1-84b0-4fa6-b265-3d4db1ca5494"

  pm_api_token_id = "root@pam!terraform"
  pm_api_token_secret = "37503755-4f2c-460a-8ff3-5c3e9af2458d"
  pm_tls_insecure = true

}


resource "proxmox_lxc" "lxc-test" {
  count = 4 
  target_node  = "pve"
  hostname     = "Ubuntu-N${count.index}"
  ostemplate   = "local:vztmpl/ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
  password     = "4theshow"
  unprivileged = true
  memory = "2048"
  cores = 2
  ssh_public_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbMRAqDeBjBu7ynbddXJK4l+kQDYpYw6EU3QPy8q0RBZrYRoI8SR3Fz541zlbjPPTMhdw6W/WT5L+3B5t9Nrg8FcnEkVomU+FoTLl+Fvb9iW9F87R2GbvpcPLXZ3hMWaAGKrJRXF5JCZWyRfFCVTPBYF6YV+TQ6NSoL/CoZOYjW882LfKM2R9Um6MixzYdN17dQncWrUhBVPeHTt+1ye5gaXIdZeYjSwYkM3vOkXy0y15ANq9JW/zeB8dDAe/Y2fKmqchyDykqhg+mtbY4qU+lyfkEvMptO7gUj93VK9VF+Eb7Z7uNK1fRvdBmrRGXe/qBEIUEBa+Vz+qUoFbAtpuF3zZ3gRgTGSiXFdg748bsGe3ZdN/bfxHq4YzuCqtb7PtEpwOGy6Cb1ovlFRoYvFKKv8iUFsh5jf7wAbc859VVbM1JEA8pY9YhWIeQsqezGKyT83l/twwlAn9YHN4Z3smZSiyAnv+NFYNWQsxwrJKyydqBdVVs5ERpaQNmPUIz3bc= norm@Normans-MacBook-Pro-2.local"

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "nvme"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
  start = true

  #creates ssh connection to check when the CT is ready for ansible provisioning
  connection {
    host = "Ubuntu-N${count.index}.home" 
    private_key = file(var.ssh_keys["priv"])
    user = "root"
    agent = false
    timeout = "3m"
  }
  provisioner "remote-exec" {
    inline = [ "echo 'Cool, we are ready for provisioning'"]
  }
#  provisioner "local-exec" {
#    working_dir = "./ansible/"
#    command = "ansible-playbook kamamilio_install.yml"
#  }

}
