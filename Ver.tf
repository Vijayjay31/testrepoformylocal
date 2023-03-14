variable "GR" {
    default = ["RG-SR-fromterra", "RG-SR-fromterra1","RG-SR-fromterra2"]
  

}

resource "azurerm_resource_group" "testrg" {
    name = "resiioll"
    location = "east us"
  
}