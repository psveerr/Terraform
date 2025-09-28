terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
provider "azurerm" {
    subscription_id="XXXXXe892-0XXXX4-4XXXXX-XXXXX8-d2XXXXXXXXXXX" # subscription ID of your respective azure account
    features {

    }
}
