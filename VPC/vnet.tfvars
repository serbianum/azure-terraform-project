region             = "East US"
vnet_name          = "terraform_project_vpc"
vnet_address_space = ["10.0.0.0/16"]
res_group          = "terraform_project"
sec_group          = "Tproject_scurity_group"
dns_servers        = ["10.0.0.4", "10.0.0.5"]
subets             = {
					   name		         = "subnet_1"
		                address_prefixes = ["10.0.1.0/24"]
		
					   name		         = "subnet_2"
					   address_prefixes  = ["10.0.2.0/24"]
		
					   name		         = "subnet_3"
					   address_prefixes  = ["10.0.3.0/24"]
						
				     }

public_key 		    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFvbM+RGtS2bjNFJg7w18WfvzQ6Zw1MR0/bH4X2eM9APxfqZF59jBeddIpJXvaY1IE+FwrivCSwk/J2DxfqL/YKOyW+iEw+NoOImkWLMSwsOm12hWZqvwt1uPqlCgUOAIGcP8hwAl7PiYgvlOA+gqybrvbd3ICXqDlykWTXLYtX0ri/KsoLdWoQAU6IIqSZZ/P7NuFg2+PLJ8mx1YWLAo8p7OVVhi26zUxABBziiJzgk3g8rF1heRR9VJgBcuTIfJ/BjkaEvjYGHEkzTnfHSQ5PCye1RhS0Za2dlAz5cMJrLg0sonQslhsgTGEJK8+rIMsckrmM/g4fEp14pnXzEWwtNEBu9+bBi8EigN21b01Ju6c+6EYIkhuvoWHUNh2gTrvJRvuMI8IDA0xY+rkfgEmZ9ASQG2+GIZj6tVdRXmF3FVvqfmB+BL1tx0sIPNDA0VhL/VDKeEe7iQFKeYhlb0Dp5luwHk+D+hF2azA2Z7qED/gW2SkyzLPk7BMaBH4FGs= mihai@cc-4960b22f-6969f4c5fb-sxps7"