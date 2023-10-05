# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

### 1 create a policy definition 

to deny the creation of resources that do not have tags

1. make the json policy and run 
```bash
    az policy definition create --name {{name-policy}} --rules policy.json
```

2. see you policy json list
```bash
    az policy assignment list
```

    it looks like
    ![list policy](./img/policy-list.png)

### 2 create a server image

1. the server image going to running with packer, the name config is server.jso, and we need to modify the enviroments in an .env file.

2. Next wo goingo to create the builders, something like that

    ![list policy](./img/config-builders.png)

3. finally you need to run:

```bash
    packer build server.json
```

4. the output looks like this



### deploy terraform linux serve

1. make sure that you have terraform in folder /terraform init with:
```bash
    terraform init
```

2. install plugins in folder /terraform
```bash
    terraform init -upgrade
```
    console looks like

![terraform init](./img/terraform_plugin.png)

3. run the terraform in folder /terraform plan with
```bash
    terraform plan -out main.plan
```
    console looks like this

![terraform ](./img/plan_init.png)

4. apply terraform plan with 
```bash
    terraform apply main.plan
```
5. Destroy flag with

```bash
    terraform plan -destroy -out main.destroy.plan
```