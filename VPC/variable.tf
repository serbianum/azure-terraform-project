variable "region" {
  type        = string
  description = "Enter region"
  default     = "us-east-1"
}

variable "sec_group"{
    type       = string
    description 
}

variable "vpc_name" {
  type        = string
  description = "Enter VPC Name"
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "Enter VPC CIDR Range"
  default     = ""
}

variable "priv_subnets" {
  type        = list(any)
  description = "Enter Private Subnets"
  default     = []
}

variable "pub_subnets" {
  type        = list(any)
  description = "Enter Private Subnets"
  default     = []
}
