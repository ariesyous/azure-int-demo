locals {
  extract_resource_name = "${var.common_name_prefix}-${var.environment}-cert"
  cert_name = substr(local.extract_resource_name, 0, 23)
}

resource "azurerm_key_vault_certificate" "main" {
  name         = local.cert_name
  key_vault_id = var.key_vault_id

  certificate {
    contents = var.certificate_p12
    password = var.certificate_p12_password
  }

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }

    key_properties {
      exportable = true
      key_type   = "RSA"
      reuse_key  = false
      key_size   = 2048
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
}