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

variable "subnets" {
	type = map(any)
	default = {
		subnet_1 = {
		  name		     ="subnet_1"
		  address_prefixes =["10.0.11.0/24"]
		}
		subnet_2 = {
		  name		     ="subnet_2"
		  address_prefixes =["10.0.12.0/24"]
		}
		subnet_3 = {
		  name		     ="subnet_3"
		  address_prefixes =["10.0.13.0/24"]
		}
	}
}

variable "public_key" {
  type        = string
  description = "Enter resource group name"
  default     = ""  
}

variable "database_admin_login" {
  type        = string
  description = "Enter database admin login"
  default     = ""  
}

variable "database_admin_password" {
  type        = string
  description = "Enter database admin password"
  default     = ""  
}

variable "db_name" {
  type        = string
  description = "Enter database name"
  default     = ""  
}

#not needed 
# variable "vm_name" {
#   type        = list
#   description = "Enter vm name"
#   default     = ["1","2",3]
# }