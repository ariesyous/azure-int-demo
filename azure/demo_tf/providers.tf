terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.10.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.5.3"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "acme" {
    #server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
    #For Production Use
    server_url = "https://acme-v02.api.letsencrypt.org/directory" 
}