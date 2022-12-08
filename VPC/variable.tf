variable "region" {
  type        = string
  description = "Enter region"
  default     = "East US"
}

variable "sec_group"{
  type        = string
  description = "Enter Security Group name"
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "Enter VPC Name"
  default     = ""
}

variable "vnet_address_space" {
  type        = list
  description = "Enter vnet address space"
  default     = [""]
}

variable "res_group" {
  type        = string
  description = "Enter resource group name"
  default     = ""  
}

variable "dns_servers" {
  type        = list
  description = "Enter DNS server"
  default     = ["",""]
}

variable "subnet_name" {
  type        = string
  description = "Enter subnet name"
  default     = "subnet1"   
}

variable "subnet_ip_range" {
  type        = list
  description = "Enter vnet address space"
  default     = ["10.0.1.0/24"]
}

variable "public_key" {
  type        = string
  description = "Enter resource group name"
  default     = ""  
}

variable "application_port" {
  description = "The port that you want to expose to the external load balancer"
  default     = 80
}

variable "admin_username" {
  description = "User name to use as the admin account on the VMs that will be part of the VM Scale Set"
  default     = "serbianum"
}

variable "admin_password" {
  description = "Default password for admin account"
  default     = "Avoidpass95"
}
# variable "subnets" {
# 	type = map(any)
# 	default = {
# 		subnet_1 = {
# 		  name		     ="subnet_1"
# 		  address_prefixes =["10.0.11.0/24"]
# 		}
# 		subnet_2 = {
# 		  name		     ="subnet_2"
# 		  address_prefixes =["10.0.12.0/24"]
# 		}
# 		subnet_3 = {
# 		  name		     ="subnet_3"
# 		  address_prefixes =["10.0.13.0/24"]
# 		}
# 	}
# }

variable "public_key" {
  type        = string
  description = "Enter resource group name"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwWXuPlRsEvNzOEEYiUoWl8EQ+TnRxbgU4jSZ2IqKSTf1bfw93+x82tL6M+l7jb2PHWEQyD/UNyq2zAzPZf06eFmtr6NNsr8ljdPEKjKDtvz8azhOtyqX7X60sUg9k4KAh52zDkjzBw+8KBxxdPPweGH2556KVedxbKpmAeXwqX/xMjken8xB1IMNpSDVtVz02NhOQ4qUNRdRJpRpZ2GT/jbf9SRP7HkLNhD4JkjGuuepLcwIsyVedPBgBntQB8JrfCC7E0US37QoOvnCJO2vvFAOrhHhl9/JTrZ6MzFR004SUGgslaKIt4Gz0Jz7ntzDig6t7jaFYDCpl1aVgT6wl+CNrNz5HS3HbCxeyCwlixgSsu26x1U4zN/Z2Vkn0grV7ROCdwRdWR72td0VT2npwYcJB3m/OxGuDf8goPbBleFNlbAg3eMalzZAeDeIVJa39gmLpKxvJz/pH/ykKpagAEjLNrtjycz19dw2egJPPfNNZ39VhpNoOv5BgHaF4/5k= serbianum@Mihais-MacBook-Pro.local"  
}

#not needed 
# variable "vm_name" {
#   type        = list
#   description = "Enter vm name"
#   default     = ["1","2",3]
# }