resource "tls_private_key" "private_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "acme_registration" "registration" {
    account_key_pem = tls_private_key.private_key.private_key_pem
    email_address   = var.email # TODO put your own email in here!
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "acme_certificate" "certificate" {
    account_key_pem           = acme_registration.registration.account_key_pem
    common_name               = var.domain_name
    subject_alternative_names = ["*.${var.domain_name}"]
    certificate_p12_password  = random_password.password.result

    dns_challenge {
        provider = "azure"

    config = {
        ARM_SUBSCRIPTION_ID  = var.subscription_id
        AZURE_CLIENT_ID      = var.client_id
        AZURE_RESOURCE_GROUP = var.resource_group_name
    }

    }



    depends_on = [acme_registration.registration]
}