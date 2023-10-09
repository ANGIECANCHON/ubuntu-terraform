# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

## Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

## Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

## Instructions

## 1. login to azure

### 1. Run the following command to login to Azure:
    follow the instructions and connect with your account

```bash
    az login
```

## 2 create a policy definition 

### 1. create the json policy and run the next command in your terminal, in <name-policy> you can put the name and the path of your json is on <url_policy>

```bash
    az policy definition create --name <name-policy> --rules <url_policy>
```

### 2. see you policy json list with this command
```bash
    az policy assignment list
```

    it looks like
    ![list policy](./img/policy-list.png)

## 2 create a server image with packer

### 1. the server image going to running with packer, the name config will be saved in a file named  <server.json>, and we need to modify the enviroments in an file <.env> file.

### 2. Next wo going go to create the builders, something like that

![builders](./img/config-builders.png)

### 3. finally you need to run:

```bash
    packer build server.json
```

## deploy terraform linux server

1. locate the folter /terraform and in the file <vars.tf> you can put the envoroments in a new  key named <default> to connect with you azure account and create the vm without problems, or in your terminal it ask to you the envs, the file looks like this:

![vars](./img/vars.png)


### 2. make sure that you have terraform in folder /terraform init with:
```bash
    terraform init
```

### 3. install plugins in folder /terraform
```bash
    terraform init -upgrade
```

### 4. run the terraform in folder /terraform plan with
```bash
    terraform plan -out main.plan
```
    console looks like this

![terraform ](./img/plan_init.png)

### 5. apply terraform plan with 
```bash
    terraform apply main.plan
```
### 6. Destroy flag with

```bash
    terraform plan -destroy -out main.destroy.plan
```

## Output


### policy definitions

1. create policy

![list policy](./img/policy-list.png)

2. list policy
![list policy](./img/config-builders.png)

### Server with packer

1. Terraform Init
```shell
    ancanchon@PCS-ANCANCHON-4 terraform % terraform init
    Initializing the backend...

    Initializing provider plugins...
    - Reusing previous version of hashicorp/random from the dependency lock file
    - Reusing previous version of azure/azapi from the dependency lock file
    - Reusing previous version of hashicorp/azurerm from the dependency lock file
    - Using previously-installed hashicorp/random v3.5.1
    - Using previously-installed azure/azapi v1.9.0
    - Using previously-installed hashicorp/azurerm v2.99.0

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
```

2. terraform init -upgrade

```shell
    ancanchon@PCS-ANCANCHON-4 terraform % terraform init -upgrade

    Initializing the backend...

    Initializing provider plugins...
    - Finding azure/azapi versions matching "~> 1.5"...
    - Finding hashicorp/azurerm versions matching "~> 2.0"...
    - Finding hashicorp/random versions matching "~> 3.0"...
    - Using previously-installed azure/azapi v1.9.0
    - Using previously-installed hashicorp/azurerm v2.99.0
    - Using previously-installed hashicorp/random v3.5.1

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
```

3. terraform plan -out main.plan

    first you need to enter password and user of your azure account, and if you was't login before you need to put in your console:

```bash
    az login --scope https://graph.microsoft.com//.default
```
    the result is like 

```bash
        A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
    [
    {
        "cloudName": "AzureCloud",
        "homeTenantId": "f958e84a-92b8-439f-a62d-4f45996b6d07",
        "id": "fe543d6c-d65a-4f94-99e0-886fb95f57dd",
        "isDefault": true,
        "managedByTenants": [],
        "name": "UdacityDS - 96",
        "state": "Enabled",
        "tenantId": "f958e84a-92b8-439f-a62d-4f45996b6d07",
        "user": {
        "name": "odl_user_242524@udacityhol.onmicrosoft.com",
        "type": "user"
        }
    }
    ]
```

and the result of terraform plan -out main.plan is
```bash
        terraform plan -out main.plan                         
    var.password
    The Azure pass default

    Enter a value: xowp93QVQ*oy

    var.username
    The Azure username default

    Enter a value: odl_user_242524@udacityhol.onmicrosoft.com


    Terraform used the selected providers to generate the following execution plan. Resource actions are
    indicated with the following symbols:
    + create
    <= read (data resources)

    Terraform will perform the following actions:

    # data.azurerm_image.main will be read during apply
    # (depends on a resource or a module with changes pending)
    <= data "azurerm_image" "main" {
        + data_disk           = (known after apply)
        + id                  = (known after apply)
        + location            = (known after apply)
        + name                = "projectPackerImage"
        + os_disk             = (known after apply)
        + resource_group_name = "Azuredevops"
        + tags                = (known after apply)
        + zone_resilient      = (known after apply)
        }

    # azapi_resource.ssh_public_key will be created
    + resource "azapi_resource" "ssh_public_key" {
        + body                      = jsonencode({})
        + id                        = (known after apply)
        + ignore_casing             = false
        + ignore_missing_property   = true
        + location                  = "eastus"
        + name                      = (known after apply)
        + output                    = (known after apply)
        + parent_id                 = (known after apply)
        + removing_special_chars    = false
        + schema_validation_enabled = true
        + tags                      = (known after apply)
        + type                      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
        }

    # azapi_resource_action.ssh_public_key_gen will be created
    + resource "azapi_resource_action" "ssh_public_key_gen" {
        + action                 = "generateKeyPair"
        + id                     = (known after apply)
        + method                 = "POST"
        + output                 = (known after apply)
        + resource_id            = (known after apply)
        + response_export_values = [
            + "publicKey",
            + "privateKey",
            ]
        + type                   = "Microsoft.Compute/sshPublicKeys@2022-11-01"
        }

    # azurerm_availability_set.main will be created
    + resource "azurerm_availability_set" "main" {
        + id                           = (known after apply)
        + location                     = "eastus"
        + managed                      = true
        + name                         = "Azuredevops-avalset"
        + platform_fault_domain_count  = 3
        + platform_update_domain_count = 5
        + resource_group_name          = "Azuredevops"
        }

    # azurerm_lb.main will be created
    + resource "azurerm_lb" "main" {
        + id                   = (known after apply)
        + location             = "eastus"
        + name                 = "Azuredevops-lb"
        + private_ip_address   = (known after apply)
        + private_ip_addresses = (known after apply)
        + resource_group_name  = "Azuredevops"
        + sku                  = "Basic"
        + sku_tier             = "Regional"

        + frontend_ip_configuration {
            + availability_zone                                  = (known after apply)
            + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
            + id                                                 = (known after apply)
            + inbound_nat_rules                                  = (known after apply)
            + load_balancer_rules                                = (known after apply)
            + name                                               = "Azuredevops-lb-public-ip"
            + outbound_rules                                     = (known after apply)
            + private_ip_address                                 = (known after apply)
            + private_ip_address_allocation                      = (known after apply)
            + private_ip_address_version                         = (known after apply)
            + public_ip_address_id                               = (known after apply)
            + public_ip_prefix_id                                = (known after apply)
            + subnet_id                                          = (known after apply)
            + zones                                              = (known after apply)
            }
        }

    # azurerm_lb_backend_address_pool.main will be created
    + resource "azurerm_lb_backend_address_pool" "main" {
        + backend_ip_configurations = (known after apply)
        + id                        = (known after apply)
        + load_balancing_rules      = (known after apply)
        + loadbalancer_id           = (known after apply)
        + name                      = "Azuredevops-lb-back"
        + outbound_rules            = (known after apply)
        + resource_group_name       = (known after apply)
        }

    # azurerm_linux_virtual_machine.main[0] will be created
    + resource "azurerm_linux_virtual_machine" "main" {
        + admin_password                  = (sensitive value)
        + admin_username                  = "odl_user_242524@udacityhol.onmicrosoft.com"
        + allow_extension_operations      = true
        + computer_name                   = "hostname"
        + disable_password_authentication = false
        + extensions_time_budget          = "PT1H30M"
        + id                              = (known after apply)
        + location                        = "eastus"
        + max_bid_price                   = -1
        + name                            = "Azuredevops-vm-0"
        + network_interface_ids           = (known after apply)
        + patch_mode                      = "ImageDefault"
        + platform_fault_domain           = -1
        + priority                        = "Regular"
        + private_ip_address              = (known after apply)
        + private_ip_addresses            = (known after apply)
        + provision_vm_agent              = true
        + public_ip_address               = (known after apply)
        + public_ip_addresses             = (known after apply)
        + resource_group_name             = "Azuredevops"
        + size                            = "Standard_D2s_v3"
        + tags                            = {
            + "environment" = "dev"
            + "project"     = "udacity"
            }
        + virtual_machine_id              = (known after apply)
        + zone                            = (known after apply)

        + admin_ssh_key {
            + public_key = (known after apply)
            + username   = "odl_user_242524@udacityhol.onmicrosoft.com"
            }

        + boot_diagnostics {
            + storage_account_uri = (known after apply)
            }

        + os_disk {
            + caching                   = "ReadWrite"
            + disk_size_gb              = (known after apply)
            + name                      = (known after apply)
            + storage_account_type      = "Standard_LRS"
            + write_accelerator_enabled = false
            }

        + source_image_reference {
            + offer     = "UbuntuServer"
            + publisher = "Canonical"
            + sku       = "18.04-LTS"
            + version   = "latest"
            }
        }

    # azurerm_linux_virtual_machine.main[1] will be created
    + resource "azurerm_linux_virtual_machine" "main" {
        + admin_password                  = (sensitive value)
        + admin_username                  = "odl_user_242524@udacityhol.onmicrosoft.com"
        + allow_extension_operations      = true
        + computer_name                   = "hostname"
        + disable_password_authentication = false
        + extensions_time_budget          = "PT1H30M"
        + id                              = (known after apply)
        + location                        = "eastus"
        + max_bid_price                   = -1
        + name                            = "Azuredevops-vm-1"
        + network_interface_ids           = (known after apply)
        + patch_mode                      = "ImageDefault"
        + platform_fault_domain           = -1
        + priority                        = "Regular"
        + private_ip_address              = (known after apply)
        + private_ip_addresses            = (known after apply)
        + provision_vm_agent              = true
        + public_ip_address               = (known after apply)
        + public_ip_addresses             = (known after apply)
        + resource_group_name             = "Azuredevops"
        + size                            = "Standard_D2s_v3"
        + tags                            = {
            + "environment" = "dev"
            + "project"     = "udacity"
            }
        + virtual_machine_id              = (known after apply)
        + zone                            = (known after apply)

        + admin_ssh_key {
            + public_key = (known after apply)
            + username   = "odl_user_242524@udacityhol.onmicrosoft.com"
            }

        + boot_diagnostics {
            + storage_account_uri = (known after apply)
            }

        + os_disk {
            + caching                   = "ReadWrite"
            + disk_size_gb              = (known after apply)
            + name                      = (known after apply)
            + storage_account_type      = "Standard_LRS"
            + write_accelerator_enabled = false
            }

        + source_image_reference {
            + offer     = "UbuntuServer"
            + publisher = "Canonical"
            + sku       = "18.04-LTS"
            + version   = "latest"
            }
        }

    # azurerm_linux_virtual_machine.main[2] will be created
    + resource "azurerm_linux_virtual_machine" "main" {
        + admin_password                  = (sensitive value)
        + admin_username                  = "odl_user_242524@udacityhol.onmicrosoft.com"
        + allow_extension_operations      = true
        + computer_name                   = "hostname"
        + disable_password_authentication = false
        + extensions_time_budget          = "PT1H30M"
        + id                              = (known after apply)
        + location                        = "eastus"
        + max_bid_price                   = -1
        + name                            = "Azuredevops-vm-2"
        + network_interface_ids           = (known after apply)
        + patch_mode                      = "ImageDefault"
        + platform_fault_domain           = -1
        + priority                        = "Regular"
        + private_ip_address              = (known after apply)
        + private_ip_addresses            = (known after apply)
        + provision_vm_agent              = true
        + public_ip_address               = (known after apply)
        + public_ip_addresses             = (known after apply)
        + resource_group_name             = "Azuredevops"
        + size                            = "Standard_D2s_v3"
        + tags                            = {
            + "environment" = "dev"
            + "project"     = "udacity"
            }
        + virtual_machine_id              = (known after apply)
        + zone                            = (known after apply)

        + admin_ssh_key {
            + public_key = (known after apply)
            + username   = "odl_user_242524@udacityhol.onmicrosoft.com"
            }

        + boot_diagnostics {
            + storage_account_uri = (known after apply)
            }

        + os_disk {
            + caching                   = "ReadWrite"
            + disk_size_gb              = (known after apply)
            + name                      = (known after apply)
            + storage_account_type      = "Standard_LRS"
            + write_accelerator_enabled = false
            }

        + source_image_reference {
            + offer     = "UbuntuServer"
            + publisher = "Canonical"
            + sku       = "18.04-LTS"
            + version   = "latest"
            }
        }

    # azurerm_network_interface.main[0] will be created
    + resource "azurerm_network_interface" "main" {
        + applied_dns_servers           = (known after apply)
        + dns_servers                   = (known after apply)
        + enable_accelerated_networking = false
        + enable_ip_forwarding          = false
        + id                            = (known after apply)
        + internal_dns_name_label       = (known after apply)
        + internal_domain_name_suffix   = (known after apply)
        + location                      = "eastus"
        + mac_address                   = (known after apply)
        + name                          = "Azuredevops-3"
        + private_ip_address            = (known after apply)
        + private_ip_addresses          = (known after apply)
        + resource_group_name           = "Azuredevops"
        + virtual_machine_id            = (known after apply)

        + ip_configuration {
            + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
            + name                                               = "internal"
            + primary                                            = (known after apply)
            + private_ip_address                                 = (known after apply)
            + private_ip_address_allocation                      = "Dynamic"
            + private_ip_address_version                         = "IPv4"
            + subnet_id                                          = (known after apply)
            }
        }

    # azurerm_network_interface.main[1] will be created
    + resource "azurerm_network_interface" "main" {
        + applied_dns_servers           = (known after apply)
        + dns_servers                   = (known after apply)
        + enable_accelerated_networking = false
        + enable_ip_forwarding          = false
        + id                            = (known after apply)
        + internal_dns_name_label       = (known after apply)
        + internal_domain_name_suffix   = (known after apply)
        + location                      = "eastus"
        + mac_address                   = (known after apply)
        + name                          = "Azuredevops-3"
        + private_ip_address            = (known after apply)
        + private_ip_addresses          = (known after apply)
        + resource_group_name           = "Azuredevops"
        + virtual_machine_id            = (known after apply)

        + ip_configuration {
            + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
            + name                                               = "internal"
            + primary                                            = (known after apply)
            + private_ip_address                                 = (known after apply)
            + private_ip_address_allocation                      = "Dynamic"
            + private_ip_address_version                         = "IPv4"
            + subnet_id                                          = (known after apply)
            }
        }

    # azurerm_network_interface.main[2] will be created
    + resource "azurerm_network_interface" "main" {
        + applied_dns_servers           = (known after apply)
        + dns_servers                   = (known after apply)
        + enable_accelerated_networking = false
        + enable_ip_forwarding          = false
        + id                            = (known after apply)
        + internal_dns_name_label       = (known after apply)
        + internal_domain_name_suffix   = (known after apply)
        + location                      = "eastus"
        + mac_address                   = (known after apply)
        + name                          = "Azuredevops-3"
        + private_ip_address            = (known after apply)
        + private_ip_addresses          = (known after apply)
        + resource_group_name           = "Azuredevops"
        + virtual_machine_id            = (known after apply)

        + ip_configuration {
            + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
            + name                                               = "internal"
            + primary                                            = (known after apply)
            + private_ip_address                                 = (known after apply)
            + private_ip_address_allocation                      = "Dynamic"
            + private_ip_address_version                         = "IPv4"
            + subnet_id                                          = (known after apply)
            }
        }

    # azurerm_network_interface_backend_address_pool_association.main[0] will be created
    + resource "azurerm_network_interface_backend_address_pool_association" "main" {
        + backend_address_pool_id = (known after apply)
        + id                      = (known after apply)
        + ip_configuration_name   = "internal"
        + network_interface_id    = (known after apply)
        }

    # azurerm_network_interface_backend_address_pool_association.main[1] will be created
    + resource "azurerm_network_interface_backend_address_pool_association" "main" {
        + backend_address_pool_id = (known after apply)
        + id                      = (known after apply)
        + ip_configuration_name   = "internal"
        + network_interface_id    = (known after apply)
        }

    # azurerm_network_interface_backend_address_pool_association.main[2] will be created
    + resource "azurerm_network_interface_backend_address_pool_association" "main" {
        + backend_address_pool_id = (known after apply)
        + id                      = (known after apply)
        + ip_configuration_name   = "internal"
        + network_interface_id    = (known after apply)
        }

    # azurerm_network_security_group.main will be created
    + resource "azurerm_network_security_group" "main" {
        + id                  = (known after apply)
        + location            = "eastus"
        + name                = "Azuredevops-network-sg"
        + resource_group_name = "Azuredevops"
        + security_rule       = [
            + {
                + access                                     = "Allow"
                + description                                = ""
                + destination_address_prefix                 = "*"
                + destination_address_prefixes               = []
                + destination_application_security_group_ids = []
                + destination_port_range                     = "*"
                + destination_port_ranges                    = []
                + direction                                  = "Inbound"
                + name                                       = "AllowSubnetConnection"
                + priority                                   = 103
                + protocol                                   = "*"
                + source_address_prefix                      = "*"
                + source_address_prefixes                    = []
                + source_application_security_group_ids      = []
                + source_port_range                          = "*"
                + source_port_ranges                         = []
                },
            + {
                + access                                     = "Allow"
                + description                                = ""
                + destination_address_prefix                 = "*"
                + destination_address_prefixes               = []
                + destination_application_security_group_ids = []
                + destination_port_range                     = "*"
                + destination_port_ranges                    = []
                + direction                                  = "Inbound"
                + name                                       = "AllowTcpAccess"
                + priority                                   = 104
                + protocol                                   = "Tcp"
                + source_address_prefix                      = "AzureLoadBalancer"
                + source_address_prefixes                    = []
                + source_application_security_group_ids      = []
                + source_port_range                          = "80"
                + source_port_ranges                         = []
                },
            + {
                + access                                     = "Allow"
                + description                                = ""
                + destination_address_prefix                 = "*"
                + destination_address_prefixes               = []
                + destination_application_security_group_ids = []
                + destination_port_range                     = "*"
                + destination_port_ranges                    = []
                + direction                                  = "Outbound"
                + name                                       = "AllowOutAccess"
                + priority                                   = 104
                + protocol                                   = "*"
                + source_address_prefix                      = "*"
                + source_address_prefixes                    = []
                + source_application_security_group_ids      = []
                + source_port_range                          = "*"
                + source_port_ranges                         = []
                },
            + {
                + access                                     = "Allow"
                + description                                = ""
                + destination_address_prefix                 = "*"
                + destination_address_prefixes               = []
                + destination_application_security_group_ids = []
                + destination_port_range                     = "22"
                + destination_port_ranges                    = []
                + direction                                  = "Inbound"
                + name                                       = "Internet"
                + priority                                   = 1001
                + protocol                                   = "Tcp"
                + source_address_prefix                      = "*"
                + source_address_prefixes                    = []
                + source_application_security_group_ids      = []
                + source_port_range                          = "*"
                + source_port_ranges                         = []
                },
            + {
                + access                                     = "Deny"
                + description                                = ""
                + destination_address_prefix                 = "*"
                + destination_address_prefixes               = []
                + destination_application_security_group_ids = []
                + destination_port_range                     = "*"
                + destination_port_ranges                    = []
                + direction                                  = "Inbound"
                + name                                       = "DenyInternetAccess"
                + priority                                   = 101
                + protocol                                   = "*"
                + source_address_prefix                      = "Internet"
                + source_address_prefixes                    = []
                + source_application_security_group_ids      = []
                + source_port_range                          = "*"
                + source_port_ranges                         = []
                },
            ]
        }

    # azurerm_public_ip.main will be created
    + resource "azurerm_public_ip" "main" {
        + allocation_method       = "Dynamic"
        + availability_zone       = (known after apply)
        + fqdn                    = (known after apply)
        + id                      = (known after apply)
        + idle_timeout_in_minutes = 4
        + ip_address              = (known after apply)
        + ip_version              = "IPv4"
        + location                = "eastus"
        + name                    = "Azuredevops-public-ip"
        + resource_group_name     = "Azuredevops"
        + sku                     = "Basic"
        + sku_tier                = "Regional"
        + zones                   = (known after apply)
        }

    # azurerm_resource_group.Azuredevops will be created
    + resource "azurerm_resource_group" "Azuredevops" {
        + id       = (known after apply)
        + location = "eastus"
        + name     = "Azuredevops"
        }

    # azurerm_storage_account.main will be created
    + resource "azurerm_storage_account" "main" {
        + access_tier                       = (known after apply)
        + account_kind                      = "StorageV2"
        + account_replication_type          = "LRS"
        + account_tier                      = "Standard"
        + allow_blob_public_access          = false
        + enable_https_traffic_only         = true
        + id                                = (known after apply)
        + infrastructure_encryption_enabled = false
        + is_hns_enabled                    = false
        + large_file_share_enabled          = (known after apply)
        + location                          = "eastus"
        + min_tls_version                   = "TLS1_0"
        + name                              = (known after apply)
        + nfsv3_enabled                     = false
        + primary_access_key                = (sensitive value)
        + primary_blob_connection_string    = (sensitive value)
        + primary_blob_endpoint             = (known after apply)
        + primary_blob_host                 = (known after apply)
        + primary_connection_string         = (sensitive value)
        + primary_dfs_endpoint              = (known after apply)
        + primary_dfs_host                  = (known after apply)
        + primary_file_endpoint             = (known after apply)
        + primary_file_host                 = (known after apply)
        + primary_location                  = (known after apply)
        + primary_queue_endpoint            = (known after apply)
        + primary_queue_host                = (known after apply)
        + primary_table_endpoint            = (known after apply)
        + primary_table_host                = (known after apply)
        + primary_web_endpoint              = (known after apply)
        + primary_web_host                  = (known after apply)
        + queue_encryption_key_type         = "Service"
        + resource_group_name               = "Azuredevops"
        + secondary_access_key              = (sensitive value)
        + secondary_blob_connection_string  = (sensitive value)
        + secondary_blob_endpoint           = (known after apply)
        + secondary_blob_host               = (known after apply)
        + secondary_connection_string       = (sensitive value)
        + secondary_dfs_endpoint            = (known after apply)
        + secondary_dfs_host                = (known after apply)
        + secondary_file_endpoint           = (known after apply)
        + secondary_file_host               = (known after apply)
        + secondary_location                = (known after apply)
        + secondary_queue_endpoint          = (known after apply)
        + secondary_queue_host              = (known after apply)
        + secondary_table_endpoint          = (known after apply)
        + secondary_table_host              = (known after apply)
        + secondary_web_endpoint            = (known after apply)
        + secondary_web_host                = (known after apply)
        + shared_access_key_enabled         = true
        + table_encryption_key_type         = "Service"
        }

    # azurerm_subnet.internal will be created
    + resource "azurerm_subnet" "internal" {
        + address_prefix                                 = (known after apply)
        + address_prefixes                               = [
            + "10.0.0.0/24",
            ]
        + enforce_private_link_endpoint_network_policies = false
        + enforce_private_link_service_network_policies  = false
        + id                                             = (known after apply)
        + name                                           = "Azuredevops-subnet"
        + resource_group_name                            = "Azuredevops"
        + virtual_network_name                           = "Azuredevops-network"
        }

    # azurerm_subnet_network_security_group_association.main will be created
    + resource "azurerm_subnet_network_security_group_association" "main" {
        + id                        = (known after apply)
        + network_security_group_id = (known after apply)
        + subnet_id                 = (known after apply)
        }

    # azurerm_virtual_network.main will be created
    + resource "azurerm_virtual_network" "main" {
        + address_space         = [
            + "10.0.0.0/24",
            ]
        + dns_servers           = (known after apply)
        + guid                  = (known after apply)
        + id                    = (known after apply)
        + location              = "eastus"
        + name                  = "Azuredevops-network"
        + resource_group_name   = "Azuredevops"
        + subnet                = (known after apply)
        + vm_protection_enabled = false
        }

    # random_id.random_id will be created
    + resource "random_id" "random_id" {
        + b64_std     = (known after apply)
        + b64_url     = (known after apply)
        + byte_length = 8
        + dec         = (known after apply)
        + hex         = (known after apply)
        + id          = (known after apply)
        + keepers     = {
            + "resource_group" = "Azuredevops"
            }
        }

    # random_pet.ssh_key_name will be created
    + resource "random_pet" "ssh_key_name" {
        + id     = (known after apply)
        + length = 2
        + prefix = "ssh"
        }

    Plan: 23 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
    + key_data            = (known after apply)
    + public_ip_addresses = [
        + (known after apply),
        + (known after apply),
        + (known after apply),
        ]
    + resource_group_name = "Azuredevops"

    ──────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: main.plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "main.plan"
```
4. terraform apply main.plan

```bash
        ancanchon@PCS-ANCANCHON-4 terraform % terraform apply main.plan       
    azurerm_resource_group.Azuredevops: Creating...
    ╷
    │ Error: A resource with the ID "/subscriptions/fe543d6c-d65a-4f94-99e0-886fb95f57dd/resourceGroups/Azuredevops" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_resource_group" for more information.
    │ 
    │   with azurerm_resource_group.Azuredevops,
    │   on main.tf line 4, in resource "azurerm_resource_group" "Azuredevops":
    │    4: resource "azurerm_resource_group" "Azuredevops" {
    │ 
```

5. Destroy terraform

```bash
    ancanchon@PCS-ANCANCHON-4 terraform % terraform plan -destroy -out main.destroy.plan
    var.password
    The Azure pass default

    Enter a value: xowp93QVQ*oy

    var.username
    The Azure username default

    Enter a value: odl_user_242524@udacityhol.onmicrosoft.com

    random_pet.ssh_key_name: Refreshing state... [id=sshdelicatemonarch]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
    - destroy

    Terraform will perform the following actions:

    # random_pet.ssh_key_name will be destroyed
    - resource "random_pet" "ssh_key_name" {
        - id     = "sshdelicatemonarch" -> null
        - length = 2 -> null
        - prefix = "ssh" -> null
        }

    Plan: 0 to add, 0 to change, 1 to destroy.

    Changes to Outputs:
    - resource_group_name = "Azuredevops" -> null

    ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: main.destroy.plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "main.destroy.plan"
    ancanchon@PCS-ANCANCHON-4 terraform % terraform apply "main.destroy.plan"
    random_pet.ssh_key_name: Destroying... [id=sshdelicatemonarch]
    random_pet.ssh_key_name: Destruction complete after 0s

    Apply complete! Resources: 0 added, 0 changed, 1 destroyed.
```