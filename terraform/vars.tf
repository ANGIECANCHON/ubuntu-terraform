# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "Azuredevops"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "East Us"
}

variable "username" {
  description = "The Azure username default"
}


variable "password" {
  description = "The Azure pass default"
}

variable "vm_number" {
  description = "The Azure count default"
  default = 3
}
