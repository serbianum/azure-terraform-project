region             = "East US"
vnet_name          = "terraform_project_vpc"
vnet_address_space = ["10.0.0.0/16"]
res_group          = "terraform_project"
sec_group          = "Tproject_scurity_group"
dns_servers        = ["10.0.0.4", "10.0.0.5"]
subnets             = {
					   name		         = "subnet_1"
		                address_prefixes = ["10.0.1.0/24"]
		
					   name		         = "subnet_2"
					   address_prefixes  = ["10.0.2.0/24"]
		
					   name		         = "subnet_3"
					   address_prefixes  = ["10.0.3.0/24"]
						
				     }