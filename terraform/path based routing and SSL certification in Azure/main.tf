resource "azurerm_resource_group" "example" {
  name     = "meow-rg"
  location = "Central India"
}

resource "azurerm_virtual_network" "example" {
  name                = "meow-vn"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "appgw_subnet" {
  name                 = "meow-subnet-agw"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "backend_subnet" {
  name                 = "meow-subnet-backend"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.254.1.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "meow-pub-ip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  frontend_ip_configuration_name = "${azurerm_virtual_network.example.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.example.name}-be-htst"
  ssl_certificate_name           = "meow-ssl-cert"
  path_map_name                  = "meow-path-map"
  port_443_name                  = "port-443"
  listener_https_name            = "https-listener-main"
  pool_default_name              = "default-pool"
  pool_web_name                  = "web-pool"
  pool_api_name                  = "api-pool"
  request_routing_rule_name      = "path-based-rule"
}

resource "azurerm_application_gateway" "network" {
  name                = "meow-appgateway"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = local.port_443_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }
  ssl_certificate {
    name     = local.ssl_certificate_name
    data     = /path/to/your/file # fill this
    password = "your-password"    # fill this 
  }

  backend_address_pool {
    name = local.pool_default_name
    ip_addresses = ["10.254.1.10"]
  }
  backend_address_pool {
    name = local.pool_web_name
    ip_addresses = ["10.254.1.11"]
  }
  backend_address_pool {
    name = local.pool_api_name
    ip_addresses = ["10.254.1.12"]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http" 
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_https_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.port_443_name
    protocol                       = "Https"             
    ssl_certificate_name           = local.ssl_certificate_name 
  }

  url_path_map {
    name                               = local.path_map_name
    default_backend_address_pool_name  = local.pool_default_name
    default_backend_http_settings_name = local.http_setting_name

    path_rule {
      name                       = "rule1"
      paths                      = ["/path1/"]
      backend_address_pool_name  = local.pool_web_name
      backend_http_settings_name = local.http_setting_name
    }

    path_rule {
      name                       = "rule2"
      paths                      = ["/path2/"]
      backend_address_pool_name  = local.pool_api_name
      backend_http_settings_name = local.http_setting_name
    }
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 100
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.listener_https_name
    url_path_map_name          = local.path_map_name
  }
}
