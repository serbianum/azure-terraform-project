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

variable "subnet1" {
  type        = string
  description = "Enter subnet 1"
}

variable "subnet2" {
  type        = string
  description = "Enter subnet 2"
}

variable "subnet3" {
  type        = string
  description = "Enter subnet 3"
}