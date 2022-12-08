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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/KF4iJs58HNgdYbxMneuVI3+e51VkJNQrHplchh5+bLyYEkJ1IOyiymreO5gdFyZ9dgBhUuEy3ZcpIQ9oDL3qx66JOojUnOD3cfofGHEpFC/pyB+764OvVgOYUORE9J6RMMTN37FFbM5zhe91Ijmsa7tYfncgT8Xxp1G/d+Ve+TFTlxm6pHlwdY0IsFVkP3hxLf0dic2Ywd/VtuFZe2FSC/6nfykqQSHeFhzKGX+Zd+FBxG+ioysSw0qEm44ntGiig0Yz9qPlcLN57jxXF69Kt73YOJLnwm3kvvno30Ro+ayY0PT2mKT10SRXQFtv9ih8Cuei+8fYfMnidspH2VwKFp7mBnX+CbnBP/RFZa++ehginz8gACAO0m9qYJJI0IERrwepoO30t6Mcd0R+ILdDE170opxVE6sIxgetLdrW+wsxql6lB+Fp2BGXwkC1KBYAnWx+onQN+nfaKA4YPaiRIbW0iA9bCyFziF2jUeX1/yByfsPDPbmoJiYkJgKtAIc= mihai@cc-6b420173-cf6fbb8cb-5bgh2"

}
#not needed 
# variable "vm_name" {
#   type        = list
#   description = "Enter vm name"
#   default     = ["1","2",3]
# }