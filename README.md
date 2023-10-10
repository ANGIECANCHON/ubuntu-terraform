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
    note: Before import if the resource already create you need to put in your console
```bash
|   terraform % terraform import azurerm_resource_group.Azuredevops /subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops
```

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
        ancanchon@PCS-ANCANCHON-4 terraform % terraform apply
    var.password
    The Azure pass default

    Enter a value: cquq64CUW*ds

    var.username
    The Azure username default

    Enter a value: odl_user_242551@udacityhol.onmicrosoft.com}

    azurerm_resource_group.Azuredevops: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops]
    data.azurerm_image.main: Reading...
    azurerm_availability_set.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset]
    azurerm_public_ip.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/Azuredevops-public-ip]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network]
    random_id.random_id: Refreshing state... [id=ASseldz2DAI]
    azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/Azuredevops-network-sg]
    azurerm_storage_account.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Storage/storageAccounts/diag012b1e95dcf60c02]
    data.azurerm_image.main: Read complete after 1s [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/projectPackerImage]
    azurerm_lb.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb]
    azurerm_subnet.internal: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet]
    azurerm_lb_backend_address_pool.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back]
    azurerm_subnet_network_security_group_association.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet]
    azurerm_network_interface.main[1]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_network_interface.main[0]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_network_interface.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_network_interface_backend_address_pool_association.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3/ipConfigurations/internal|/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back]
    azurerm_linux_virtual_machine.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
    + create
    -/+ destroy and then create replacement

    Terraform will perform the following actions:

    # azurerm_linux_virtual_machine.main[0] will be created
    + resource "azurerm_linux_virtual_machine" "main" {
        + admin_password                  = (sensitive value)
        + admin_username                  = "odl_user_242551@udacityhol.onmicrosoft.com}"
        + allow_extension_operations      = true
        + availability_set_id             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset"
        + computer_name                   = (known after apply)
        + disable_password_authentication = false
        + extensions_time_budget          = "PT1H30M"
        + id                              = (known after apply)
        + location                        = "eastus"
        + max_bid_price                   = -1
        + name                            = "Azuredevops-vm-0"
        + network_interface_ids           = [
            + "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3",
            ]
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
        + source_image_id                 = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/projectPackerImage"
        + tags                            = {
            + "environment" = "dev"
            + "project"     = "udacity"
            }
        + virtual_machine_id              = (known after apply)
        + zone                            = (known after apply)

        + os_disk {
            + caching                   = "ReadWrite"
            + disk_size_gb              = (known after apply)
            + name                      = (known after apply)
            + storage_account_type      = "Standard_LRS"
            + write_accelerator_enabled = false
            }
        }

    # azurerm_linux_virtual_machine.main[1] will be created
    + resource "azurerm_linux_virtual_machine" "main" {
        + admin_password                  = (sensitive value)
        + admin_username                  = "odl_user_242551@udacityhol.onmicrosoft.com}"
        + allow_extension_operations      = true
        + availability_set_id             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset"
        + computer_name                   = (known after apply)
        + disable_password_authentication = false
        + extensions_time_budget          = "PT1H30M"
        + id                              = (known after apply)
        + location                        = "eastus"
        + max_bid_price                   = -1
        + name                            = "Azuredevops-vm-1"
        + network_interface_ids           = [
            + "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3",
            ]
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
        + source_image_id                 = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/projectPackerImage"
        + tags                            = {
            + "environment" = "dev"
            + "project"     = "udacity"
            }
        + virtual_machine_id              = (known after apply)
        + zone                            = (known after apply)

        + os_disk {
            + caching                   = "ReadWrite"
            + disk_size_gb              = (known after apply)
            + name                      = (known after apply)
            + storage_account_type      = "Standard_LRS"
            + write_accelerator_enabled = false
            }
        }

    # azurerm_linux_virtual_machine.main[2] must be replaced
    -/+ resource "azurerm_linux_virtual_machine" "main" {
        ~ admin_username                  = "odl_user_242551@udacityhol.onmicrosoft.com" -> "odl_user_242551@udacityhol.onmicrosoft.com}" # forces replacement
        ~ availability_set_id             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/AZUREDEVOPS-AVALSET" -> "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset"
        ~ computer_name                   = "Azuredevops-vm-2" -> (known after apply)
        - encryption_at_host_enabled      = false -> null
        ~ id                              = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2" -> (known after apply)
            name                            = "Azuredevops-vm-2"
        ~ private_ip_address              = "10.0.0.4" -> (known after apply)
        ~ private_ip_addresses            = [
            - "10.0.0.4",
            ] -> (known after apply)
        + public_ip_address               = (known after apply)
        ~ public_ip_addresses             = [] -> (known after apply)
        - secure_boot_enabled             = false -> null
            tags                            = {
                "environment" = "dev"
                "project"     = "udacity"
            }
        ~ virtual_machine_id              = "9ec86194-4e55-41b7-a5f8-db326583ce8a" -> (known after apply)
        - vtpm_enabled                    = false -> null
        + zone                            = (known after apply)
            # (14 unchanged attributes hidden)

        ~ os_disk {
            ~ disk_size_gb              = 30 -> (known after apply)
            ~ name                      = "Azuredevops-vm-2_disk1_65b6539f8d084a4c9a8787070739884c" -> (known after apply)
                # (3 unchanged attributes hidden)
            }
        }

    # azurerm_network_interface_backend_address_pool_association.main[0] will be created
    + resource "azurerm_network_interface_backend_address_pool_association" "main" {
        + backend_address_pool_id = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back"
        + id                      = (known after apply)
        + ip_configuration_name   = "internal"
        + network_interface_id    = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3"
        }

    # azurerm_network_interface_backend_address_pool_association.main[1] will be created
    + resource "azurerm_network_interface_backend_address_pool_association" "main" {
        + backend_address_pool_id = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back"
        + id                      = (known after apply)
        + ip_configuration_name   = "internal"
        + network_interface_id    = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3"
        }

    Plan: 5 to add, 0 to change, 1 to destroy.

    Changes to Outputs:
    + public_ip_addresses   = [
        + (known after apply),
        + (known after apply),
        + (known after apply),
        ]
    ╷
    │ Warning: Value for undeclared variable
    │ 
    │ The root module does not declare a variable named "tenant_id" but a value was found in file "terraform.tfvars". If
    │ you meant to use this value, add a "variable" block to the configuration.
    │ 
    │ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all
    │ configurations in your organization. To reduce the verbosity of these warnings, use the -compact-warnings option.
    ╵
    ╷
    │ Warning: Value for undeclared variable
    │ 
    │ The root module does not declare a variable named "application_type" but a value was found in file
    │ "terraform.tfvars". If you meant to use this value, add a "variable" block to the configuration.
    │ 
    │ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all
    │ configurations in your organization. To reduce the verbosity of these warnings, use the -compact-warnings option.
    ╵
    ╷
    │ Warning: Values for undeclared variables
    │ 
    │ In addition to the other similar warnings shown, 8 other variable(s) defined without being declared.
    ╵

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

    azurerm_linux_virtual_machine.main[2]: Destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2]
    azurerm_network_interface_backend_address_pool_association.main[1]: Creating...
    azurerm_network_interface_backend_address_pool_association.main[0]: Creating...
    azurerm_linux_virtual_machine.main[1]: Creating...
    azurerm_linux_virtual_machine.main[0]: Creating...
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 10s elapsed]
    azurerm_network_interface_backend_address_pool_association.main[0]: Still creating... [10s elapsed]
    azurerm_network_interface_backend_address_pool_association.main[1]: Still creating... [10s elapsed]
    azurerm_linux_virtual_machine.main[1]: Still creating... [10s elapsed]
    azurerm_linux_virtual_machine.main[0]: Still creating... [10s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 20s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 30s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 40s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 50s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 1m0s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 1m10s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 1m20s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still destroying... [id=/subscriptions/c761712a-772e-4832-b4d5-...mpute/virtualMachines/Azuredevops-vm-2, 1m30s elapsed]
    azurerm_linux_virtual_machine.main[2]: Destruction complete after 1m38s
    azurerm_linux_virtual_machine.main[2]: Creating...
    azurerm_linux_virtual_machine.main[2]: Still creating... [10s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still creating... [20s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still creating... [30s elapsed]
    azurerm_linux_virtual_machine.main[2]: Still creating... [40s elapsed]
    azurerm_linux_virtual_machine.main[2]: Creation complete after 49s [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2]
```

5. Destroy terraform

```bash
        terraform plan -destroy -out main.destroy.plan
    var.password
    The Azure pass default

    Enter a value: cquq64CUW*ds

    var.username
    The Azure username default

    Enter a value: odl_user_242551@udacityhol.onmicrosoft.com

    azurerm_resource_group.Azuredevops: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops]
    data.azurerm_image.main: Reading...
    azurerm_availability_set.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network]
    azurerm_public_ip.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/Azuredevops-public-ip]
    random_id.random_id: Refreshing state... [id=ASseldz2DAI]
    azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/Azuredevops-network-sg]
    azurerm_storage_account.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Storage/storageAccounts/diag012b1e95dcf60c02]
    azurerm_subnet.internal: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet]
    azurerm_lb.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb]
    data.azurerm_image.main: Read complete after 1s [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/projectPackerImage]
    azurerm_subnet_network_security_group_association.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet]
    azurerm_network_interface.main[0]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_network_interface.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_lb_backend_address_pool.main: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back]
    azurerm_network_interface.main[1]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3]
    azurerm_network_interface_backend_address_pool_association.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3/ipConfigurations/internal|/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back]
    azurerm_linux_virtual_machine.main[2]: Refreshing state... [id=/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
    - destroy

    Terraform will perform the following actions:

    # azurerm_availability_set.main will be destroyed
    - resource "azurerm_availability_set" "main" {
        - id                           = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/Azuredevops-avalset" -> null
        - location                     = "eastus" -> null
        - managed                      = true -> null
        - name                         = "Azuredevops-avalset" -> null
        - platform_fault_domain_count  = 3 -> null
        - platform_update_domain_count = 5 -> null
        - resource_group_name          = "Azuredevops" -> null
        - tags                         = {} -> null
        }

    # azurerm_lb.main will be destroyed
    - resource "azurerm_lb" "main" {
        - id                   = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb" -> null
        - location             = "eastus" -> null
        - name                 = "Azuredevops-lb" -> null
        - private_ip_addresses = [] -> null
        - resource_group_name  = "Azuredevops" -> null
        - sku                  = "Basic" -> null
        - sku_tier             = "Regional" -> null
        - tags                 = {} -> null

        - frontend_ip_configuration {
            - availability_zone             = "No-Zone" -> null
            - id                            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/frontendIPConfigurations/Azuredevops-lb-public-ip" -> null
            - inbound_nat_rules             = [] -> null
            - load_balancer_rules           = [] -> null
            - name                          = "Azuredevops-lb-public-ip" -> null
            - outbound_rules                = [] -> null
            - private_ip_address_allocation = "Dynamic" -> null
            - public_ip_address_id          = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/Azuredevops-public-ip" -> null
            - zones                         = [] -> null
            }
        }

    # azurerm_lb_backend_address_pool.main will be destroyed
    - resource "azurerm_lb_backend_address_pool" "main" {
        - backend_ip_configurations = [
            - "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3/ipConfigurations/internal",
            ] -> null
        - id                        = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back" -> null
        - load_balancing_rules      = [] -> null
        - loadbalancer_id           = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb" -> null
        - name                      = "Azuredevops-lb-back" -> null
        - outbound_rules            = [] -> null
        - resource_group_name       = "Azuredevops" -> null
        }

    # azurerm_linux_virtual_machine.main[2] will be destroyed
    - resource "azurerm_linux_virtual_machine" "main" {
        - admin_password                  = (sensitive value) -> null
        - admin_username                  = "odl_user_242551@udacityhol.onmicrosoft.com}" -> null
        - allow_extension_operations      = true -> null
        - availability_set_id             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/AZUREDEVOPS-AVALSET" -> null
        - computer_name                   = "Azuredevops-vm-2" -> null
        - disable_password_authentication = false -> null
        - encryption_at_host_enabled      = false -> null
        - extensions_time_budget          = "PT1H30M" -> null
        - id                              = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2" -> null
        - location                        = "eastus" -> null
        - max_bid_price                   = -1 -> null
        - name                            = "Azuredevops-vm-2" -> null
        - network_interface_ids           = [
            - "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3",
            ] -> null
        - patch_mode                      = "ImageDefault" -> null
        - platform_fault_domain           = -1 -> null
        - priority                        = "Regular" -> null
        - private_ip_address              = "10.0.0.4" -> null
        - private_ip_addresses            = [
            - "10.0.0.4",
            ] -> null
        - provision_vm_agent              = true -> null
        - public_ip_addresses             = [] -> null
        - resource_group_name             = "Azuredevops" -> null
        - secure_boot_enabled             = false -> null
        - size                            = "Standard_D2s_v3" -> null
        - source_image_id                 = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/projectPackerImage" -> null
        - tags                            = {
            - "environment" = "dev"
            - "project"     = "udacity"
            } -> null
        - virtual_machine_id              = "e88e915d-1da8-4cfe-8561-79d89ad0e7fa" -> null
        - vtpm_enabled                    = false -> null

        - os_disk {
            - caching                   = "ReadWrite" -> null
            - disk_size_gb              = 30 -> null
            - name                      = "Azuredevops-vm-2_disk1_42f10017acee4432a70954b7bcde6068" -> null
            - storage_account_type      = "Standard_LRS" -> null
            - write_accelerator_enabled = false -> null
            }
        }

    # azurerm_network_interface.main[0] will be destroyed
    - resource "azurerm_network_interface" "main" {
        - applied_dns_servers           = [] -> null
        - dns_servers                   = [] -> null
        - enable_accelerated_networking = false -> null
        - enable_ip_forwarding          = false -> null
        - id                            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3" -> null
        - internal_domain_name_suffix   = "wmw2kp2h2f1eja4uwat4czjymc.bx.internal.cloudapp.net" -> null
        - location                      = "eastus" -> null
        - mac_address                   = "00-22-48-34-14-E8" -> null
        - name                          = "Azuredevops-3" -> null
        - private_ip_address            = "10.0.0.4" -> null
        - private_ip_addresses          = [
            - "10.0.0.4",
            ] -> null
        - resource_group_name           = "Azuredevops" -> null
        - tags                          = {} -> null
        - virtual_machine_id            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2" -> null

        - ip_configuration {
            - name                          = "internal" -> null
            - primary                       = true -> null
            - private_ip_address            = "10.0.0.4" -> null
            - private_ip_address_allocation = "Dynamic" -> null
            - private_ip_address_version    = "IPv4" -> null
            - subnet_id                     = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
            }
        }

    # azurerm_network_interface.main[1] will be destroyed
    - resource "azurerm_network_interface" "main" {
        - applied_dns_servers           = [] -> null
        - dns_servers                   = [] -> null
        - enable_accelerated_networking = false -> null
        - enable_ip_forwarding          = false -> null
        - id                            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3" -> null
        - internal_domain_name_suffix   = "wmw2kp2h2f1eja4uwat4czjymc.bx.internal.cloudapp.net" -> null
        - location                      = "eastus" -> null
        - mac_address                   = "00-22-48-34-14-E8" -> null
        - name                          = "Azuredevops-3" -> null
        - private_ip_address            = "10.0.0.4" -> null
        - private_ip_addresses          = [
            - "10.0.0.4",
            ] -> null
        - resource_group_name           = "Azuredevops" -> null
        - tags                          = {} -> null
        - virtual_machine_id            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2" -> null

        - ip_configuration {
            - name                          = "internal" -> null
            - primary                       = true -> null
            - private_ip_address            = "10.0.0.4" -> null
            - private_ip_address_allocation = "Dynamic" -> null
            - private_ip_address_version    = "IPv4" -> null
            - subnet_id                     = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
            }
        }

    # azurerm_network_interface.main[2] will be destroyed
    - resource "azurerm_network_interface" "main" {
        - applied_dns_servers           = [] -> null
        - dns_servers                   = [] -> null
        - enable_accelerated_networking = false -> null
        - enable_ip_forwarding          = false -> null
        - id                            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3" -> null
        - internal_domain_name_suffix   = "wmw2kp2h2f1eja4uwat4czjymc.bx.internal.cloudapp.net" -> null
        - location                      = "eastus" -> null
        - mac_address                   = "00-22-48-34-14-E8" -> null
        - name                          = "Azuredevops-3" -> null
        - private_ip_address            = "10.0.0.4" -> null
        - private_ip_addresses          = [
            - "10.0.0.4",
            ] -> null
        - resource_group_name           = "Azuredevops" -> null
        - tags                          = {} -> null
        - virtual_machine_id            = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/Azuredevops-vm-2" -> null

        - ip_configuration {
            - name                          = "internal" -> null
            - primary                       = true -> null
            - private_ip_address            = "10.0.0.4" -> null
            - private_ip_address_allocation = "Dynamic" -> null
            - private_ip_address_version    = "IPv4" -> null
            - subnet_id                     = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
            }
        }

    # azurerm_network_interface_backend_address_pool_association.main[2] will be destroyed
    - resource "azurerm_network_interface_backend_address_pool_association" "main" {
        - backend_address_pool_id = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back" -> null
        - id                      = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3/ipConfigurations/internal|/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/Azuredevops-lb/backendAddressPools/Azuredevops-lb-back" -> null
        - ip_configuration_name   = "internal" -> null
        - network_interface_id    = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/Azuredevops-3" -> null
        }

    # azurerm_network_security_group.main will be destroyed
    - resource "azurerm_network_security_group" "main" {
        - id                  = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/Azuredevops-network-sg" -> null
        - location            = "eastus" -> null
        - name                = "Azuredevops-network-sg" -> null
        - resource_group_name = "Azuredevops" -> null
        - security_rule       = [
            - {
                - access                                     = "Allow"
                - description                                = ""
                - destination_address_prefix                 = "*"
                - destination_address_prefixes               = []
                - destination_application_security_group_ids = []
                - destination_port_range                     = "*"
                - destination_port_ranges                    = []
                - direction                                  = "Inbound"
                - name                                       = "AllowSubnetConnection"
                - priority                                   = 103
                - protocol                                   = "*"
                - source_address_prefix                      = "*"
                - source_address_prefixes                    = []
                - source_application_security_group_ids      = []
                - source_port_range                          = "*"
                - source_port_ranges                         = []
                },
            - {
                - access                                     = "Allow"
                - description                                = ""
                - destination_address_prefix                 = "*"
                - destination_address_prefixes               = []
                - destination_application_security_group_ids = []
                - destination_port_range                     = "*"
                - destination_port_ranges                    = []
                - direction                                  = "Inbound"
                - name                                       = "AllowTcpAccess"
                - priority                                   = 104
                - protocol                                   = "Tcp"
                - source_address_prefix                      = "AzureLoadBalancer"
                - source_address_prefixes                    = []
                - source_application_security_group_ids      = []
                - source_port_range                          = "80"
                - source_port_ranges                         = []
                },
            - {
                - access                                     = "Allow"
                - description                                = ""
                - destination_address_prefix                 = "*"
                - destination_address_prefixes               = []
                - destination_application_security_group_ids = []
                - destination_port_range                     = "*"
                - destination_port_ranges                    = []
                - direction                                  = "Outbound"
                - name                                       = "AllowOutAccess"
                - priority                                   = 104
                - protocol                                   = "*"
                - source_address_prefix                      = "*"
                - source_address_prefixes                    = []
                - source_application_security_group_ids      = []
                - source_port_range                          = "*"
                - source_port_ranges                         = []
                },
            - {
                - access                                     = "Allow"
                - description                                = ""
                - destination_address_prefix                 = "*"
                - destination_address_prefixes               = []
                - destination_application_security_group_ids = []
                - destination_port_range                     = "22"
                - destination_port_ranges                    = []
                - direction                                  = "Inbound"
                - name                                       = "Internet"
                - priority                                   = 1001
                - protocol                                   = "Tcp"
                - source_address_prefix                      = "*"
                - source_address_prefixes                    = []
                - source_application_security_group_ids      = []
                - source_port_range                          = "*"
                - source_port_ranges                         = []
                },
            - {
                - access                                     = "Deny"
                - description                                = ""
                - destination_address_prefix                 = "*"
                - destination_address_prefixes               = []
                - destination_application_security_group_ids = []
                - destination_port_range                     = "*"
                - destination_port_ranges                    = []
                - direction                                  = "Inbound"
                - name                                       = "DenyInternetAccess"
                - priority                                   = 101
                - protocol                                   = "*"
                - source_address_prefix                      = "Internet"
                - source_address_prefixes                    = []
                - source_application_security_group_ids      = []
                - source_port_range                          = "*"
                - source_port_ranges                         = []
                },
            ] -> null
        - tags                = {} -> null
        }

    # azurerm_public_ip.main will be destroyed
    - resource "azurerm_public_ip" "main" {
        - allocation_method       = "Dynamic" -> null
        - availability_zone       = "No-Zone" -> null
        - id                      = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/Azuredevops-public-ip" -> null
        - idle_timeout_in_minutes = 4 -> null
        - ip_tags                 = {} -> null
        - ip_version              = "IPv4" -> null
        - location                = "eastus" -> null
        - name                    = "Azuredevops-public-ip" -> null
        - resource_group_name     = "Azuredevops" -> null
        - sku                     = "Basic" -> null
        - sku_tier                = "Regional" -> null
        - tags                    = {} -> null
        - zones                   = [] -> null
        }

    # azurerm_resource_group.Azuredevops will be destroyed
    - resource "azurerm_resource_group" "Azuredevops" {
        - id       = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops" -> null
        - location = "eastus" -> null
        - name     = "Azuredevops" -> null
        - tags     = {} -> null
        }

    # azurerm_storage_account.main will be destroyed
    - resource "azurerm_storage_account" "main" {
        - access_tier                       = "Hot" -> null
        - account_kind                      = "StorageV2" -> null
        - account_replication_type          = "LRS" -> null
        - account_tier                      = "Standard" -> null
        - allow_blob_public_access          = false -> null
        - enable_https_traffic_only         = true -> null
        - id                                = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Storage/storageAccounts/diag012b1e95dcf60c02" -> null
        - infrastructure_encryption_enabled = false -> null
        - is_hns_enabled                    = false -> null
        - location                          = "eastus" -> null
        - min_tls_version                   = "TLS1_0" -> null
        - name                              = "diag012b1e95dcf60c02" -> null
        - nfsv3_enabled                     = false -> null
        - primary_access_key                = (sensitive value) -> null
        - primary_blob_connection_string    = (sensitive value) -> null
        - primary_blob_endpoint             = "https://diag012b1e95dcf60c02.blob.core.windows.net/" -> null
        - primary_blob_host                 = "diag012b1e95dcf60c02.blob.core.windows.net" -> null
        - primary_connection_string         = (sensitive value) -> null
        - primary_dfs_endpoint              = "https://diag012b1e95dcf60c02.dfs.core.windows.net/" -> null
        - primary_dfs_host                  = "diag012b1e95dcf60c02.dfs.core.windows.net" -> null
        - primary_file_endpoint             = "https://diag012b1e95dcf60c02.file.core.windows.net/" -> null
        - primary_file_host                 = "diag012b1e95dcf60c02.file.core.windows.net" -> null
        - primary_location                  = "eastus" -> null
        - primary_queue_endpoint            = "https://diag012b1e95dcf60c02.queue.core.windows.net/" -> null
        - primary_queue_host                = "diag012b1e95dcf60c02.queue.core.windows.net" -> null
        - primary_table_endpoint            = "https://diag012b1e95dcf60c02.table.core.windows.net/" -> null
        - primary_table_host                = "diag012b1e95dcf60c02.table.core.windows.net" -> null
        - primary_web_endpoint              = "https://diag012b1e95dcf60c02.z13.web.core.windows.net/" -> null
        - primary_web_host                  = "diag012b1e95dcf60c02.z13.web.core.windows.net" -> null
        - queue_encryption_key_type         = "Service" -> null
        - resource_group_name               = "Azuredevops" -> null
        - secondary_access_key              = (sensitive value) -> null
        - secondary_connection_string       = (sensitive value) -> null
        - shared_access_key_enabled         = true -> null
        - table_encryption_key_type         = "Service" -> null
        - tags                              = {} -> null

        - blob_properties {
            - change_feed_enabled      = false -> null
            - last_access_time_enabled = false -> null
            - versioning_enabled       = false -> null
            }

        - network_rules {
            - bypass                     = [
                - "AzureServices",
                ] -> null
            - default_action             = "Allow" -> null
            - ip_rules                   = [] -> null
            - virtual_network_subnet_ids = [] -> null
            }

        - queue_properties {
            - hour_metrics {
                - enabled               = true -> null
                - include_apis          = true -> null
                - retention_policy_days = 7 -> null
                - version               = "1.0" -> null
                }
            - logging {
                - delete                = false -> null
                - read                  = false -> null
                - retention_policy_days = 0 -> null
                - version               = "1.0" -> null
                - write                 = false -> null
                }
            - minute_metrics {
                - enabled               = false -> null
                - include_apis          = false -> null
                - retention_policy_days = 0 -> null
                - version               = "1.0" -> null
                }
            }

        - share_properties {
            - retention_policy {
                - days = 7 -> null
                }
            }
        }

    # azurerm_subnet.internal will be destroyed
    - resource "azurerm_subnet" "internal" {
        - address_prefix                                 = "10.0.0.0/24" -> null
        - address_prefixes                               = [
            - "10.0.0.0/24",
            ] -> null
        - enforce_private_link_endpoint_network_policies = false -> null
        - enforce_private_link_service_network_policies  = false -> null
        - id                                             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
        - name                                           = "Azuredevops-subnet" -> null
        - resource_group_name                            = "Azuredevops" -> null
        - service_endpoint_policy_ids                    = [] -> null
        - service_endpoints                              = [] -> null
        - virtual_network_name                           = "Azuredevops-network" -> null
        }

    # azurerm_subnet_network_security_group_association.main will be destroyed
    - resource "azurerm_subnet_network_security_group_association" "main" {
        - id                        = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
        - network_security_group_id = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/Azuredevops-network-sg" -> null
        - subnet_id                 = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet" -> null
        }

    # azurerm_virtual_network.main will be destroyed
    - resource "azurerm_virtual_network" "main" {
        - address_space           = [
            - "10.0.0.0/24",
            ] -> null
        - dns_servers             = [] -> null
        - flow_timeout_in_minutes = 0 -> null
        - guid                    = "3fc52db3-e187-4476-83d4-b027e1653862" -> null
        - id                      = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network" -> null
        - location                = "eastus" -> null
        - name                    = "Azuredevops-network" -> null
        - resource_group_name     = "Azuredevops" -> null
        - subnet                  = [
            - {
                - address_prefix = "10.0.0.0/24"
                - id             = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/Azuredevops-network/subnets/Azuredevops-subnet"
                - name           = "Azuredevops-subnet"
                - security_group = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/Azuredevops-network-sg"
                },
            ] -> null
        - tags                    = {} -> null
        - vm_protection_enabled   = false -> null
        }

    # random_id.random_id will be destroyed
    - resource "random_id" "random_id" {
        - b64_std     = "ASseldz2DAI=" -> null
        - b64_url     = "ASseldz2DAI" -> null
        - byte_length = 8 -> null
        - dec         = "84194647042558978" -> null
        - hex         = "012b1e95dcf60c02" -> null
        - id          = "ASseldz2DAI" -> null
        - keepers     = {
            - "resource_group" = "Azuredevops"
            } -> null
        }

    Plan: 0 to add, 0 to change, 16 to destroy.

    Changes to Outputs:
    - ip_configuration_name = [
        - "internal",
        - "internal",
        - "internal",
        ] -> null
    - resource_group_name   = "Azuredevops" -> null
    ╷
    │ Warning: Value for undeclared variable
    │ 
    │ The root module does not declare a variable named "client_id" but a value was found in file "terraform.tfvars". If
    │ you meant to use this value, add a "variable" block to the configuration.
    │ 
    │ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all
    │ configurations in your organization. To reduce the verbosity of these warnings, use the -compact-warnings option.
    ╵
    ╷
    │ Warning: Value for undeclared variable
    │ 
    │ The root module does not declare a variable named "packer_image_id" but a value was found in file "terraform.tfvars".
    │ If you meant to use this value, add a "variable" block to the configuration.
    │ 
    │ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all
    │ configurations in your organization. To reduce the verbosity of these warnings, use the -compact-warnings option.
    ╵
    ╷
    │ Warning: Values for undeclared variables
    │ 
    │ In addition to the other similar warnings shown, 8 other variable(s) defined without being declared.
    ╵

    ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: main.destroy.plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "main.destroy.plan"
```