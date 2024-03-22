variable "pm_api_url" {
  type = string
}
variable "pm_api_token_id" {
  type = string
}
variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}
#Set your public SSH key here
variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbMRAqDeBjBu7ynbddXJK4l+kQDYpYw6EU3QPy8q0RBZrYRoI8SR3Fz541zlbjPPTMhdw6W/WT5L+3B5t9Nrg8FcnEkVomU+FoTLl+Fvb9iW9F87R2GbvpcPLXZ3hMWaAGKrJRXF5JCZWyRfFCVTPBYF6YV+TQ6NSoL/CoZOYjW882LfKM2R9Um6MixzYdN17dQncWrUhBVPeHTt+1ye5gaXIdZeYjSwYkM3vOkXy0y15ANq9JW/zeB8dDAe/Y2fKmqchyDykqhg+mtbY4qU+lyfkEvMptO7gUj93VK9VF+Eb7Z7uNK1fRvdBmrRGXe/qBEIUEBa+Vz+qUoFbAtpuF3zZ3gRgTGSiXFdg748bsGe3ZdN/bfxHq4YzuCqtb7PtEpwOGy6Cb1ovlFRoYvFKKv8iUFsh5jf7wAbc859VVbM1JEA8pY9YhWIeQsqezGKyT83l/twwlAn9YHN4Z3smZSiyAnv+NFYNWQsxwrJKyydqBdVVs5ERpaQNmPUIz3bc= norm@Normans-MacBook-Pro-2.local" 
}

variable "ssh_keys" {
     type = map
     default = {
       pub  = "~/.ssh/id_rsa.pub"
       priv = "~/.ssh/id_rsa"
     }
}
