variable "location" {
  description = "Azure regio voor de resources."
  type        = string
  default     = "westeurope"
}

variable "name_prefix" {
  description = "Prefix voor Azure resource namen."
  type        = string
  default     = "les03-prod"
}

variable "admin_username" {
  description = "Linux gebruiker voor SSH-login."
  type        = string
  default     = "iac"
}

variable "ssh_public_key_path" {
  description = "Pad naar je publieke ED25519 SSH key."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "vm_size" {
  description = "Azure VM sizing."
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "allowed_ssh_source" {
  description = "Bron-IP voor SSH. Gebruik voor een lab eventueel 0.0.0.0/0, maar beperk dit waar mogelijk."
  type        = string
  default     = "0.0.0.0/0"
}

variable "vms" {
  description = "VM's voor productie: twee webservers en een databaseserver."
  type = map(object({
    role              = string
    private_ip_suffix = number
  }))

  default = {
    webserver-1 = {
      role              = "webserver"
      private_ip_suffix = 10
    }
    webserver-2 = {
      role              = "webserver"
      private_ip_suffix = 11
    }
    databaseserver-1 = {
      role              = "database"
      private_ip_suffix = 20
    }
  }
}
